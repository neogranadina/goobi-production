/**
 * This file is part of the Goobi Application - a Workflow tool for the support
 * of mass digitization.
 * 
 * (c) 2014 Goobi. Digitalisieren im Verein e.V. &lt;contact@goobi.org&gt;
 * 
 * Visit the websites for more information.
 *     		- http://www.goobi.org/en/
 *     		- https://github.com/goobi
 * 
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Linking this library statically or dynamically with other modules is making a
 * combined work based on this library. Thus, the terms and conditions of the
 * GNU General Public License cover the whole combination. As a special
 * exception, the copyright holders of this library give you permission to link
 * this library with independent modules to produce an executable, regardless of
 * the license terms of these independent modules, and to copy and distribute
 * the resulting executable under terms of your choice, provided that you also
 * meet, for each linked independent module, the terms and conditions of the
 * license of that module. An independent module is a module which is not
 * derived from or based on this library. If you modify this library, you may
 * extend this exception to your version of the library, but you are not obliged
 * to do so. If you do not wish to do so, delete this exception statement from
 * your version.
 */
package de.sub.goobi.metadaten.copier;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.lang.StringUtils;
import org.joda.time.format.ISODateTimeFormat;

/**
 * Data copy rule that either overwrites the metadatum described by the selector
 * on the left hand side or creates it anew, if it isn’t yet present.
 * 
 * @author Matthias Ronge &lt;matthias.ronge@zeutschel.de&gt;
 */
public class ComposeFormattedRule extends DataCopyrule {

	/**
	 * Scheme to locate indexed format expressions
	 */
	private static final Pattern FORMAT_CODES_SCHEME = Pattern
			.compile("%(\\d+)\\$[ #(+,-0]*(?:[1-9][0-9]*)?([%ABCEGHSTXabcdefghnostx])");

	/**
	 * Operator representing the OverwriteOrCreateRule in the data copier syntax
	 */
	protected static final String OPERATOR = "=format";

	/**
	 * The function typecast() converts the String arguments so that they can be
	 * used by {@link String#format(String, Object...)}. Only arguments that are
	 * referenced by number can be typecasted. If the format String contains
	 * “%2$02d”, the function will convert the second list object to long, if
	 * the format String contains “%02d” the function cannot tell which argument
	 * is meant and thus doesn’t do anything for it.
	 * 
	 * @param format
	 *            format String, to get the desired types from
	 * @param elements
	 *            arguments
	 * @return the objects for the format command
	 */
	private static Object[] typecast(String format, List<String> elements) {
		Object[] result = elements.toArray();
		Matcher expressions = FORMAT_CODES_SCHEME.matcher(format);
		while (expressions.find()) {
			try {
				int i = Integer.parseInt(expressions.group(1)) - 1;
				switch (expressions.group(2).codePointAt(0)) {
				case 'A':
					result[i] = Double.parseDouble(elements.get(i));
					continue;
				case 'C':
					result[i] = Integer.parseInt(elements.get(i));
					continue;
				case 'E':
				case 'G':
					result[i] = Double.parseDouble(elements.get(i));
					continue;
				case 'T':
					result[i] = ISODateTimeFormat.dateElementParser().parseMillis(elements.get(i));
					continue;
				case 'X':
					result[i] = Long.parseLong(elements.get(i));
					continue;
				case 'a':
					result[i] = Double.parseDouble(elements.get(i));
					continue;
				case 'c':
					result[i] = Integer.parseInt(elements.get(i));
					continue;
				case 'd':
					result[i] = Long.parseLong(elements.get(i));
					continue;
				case 'e':
				case 'f':
				case 'g':
					result[i] = Double.parseDouble(elements.get(i));
					continue;
				case 'o':
					result[i] = Long.parseLong(elements.get(i));
					continue;
				case 't':
					result[i] = ISODateTimeFormat.dateElementParser().parseMillis(elements.get(i));
					continue;
				case 'x':
					result[i] = Long.parseLong(elements.get(i));
				}
			} catch (RuntimeException e) {// ArrayIndexOutOfBoundsException, ClassCastException, NumberFormatException
				continue;
			}
		}
		return result;
	}

	/**
	 * Selector for the metadatum to be overwritten or created
	 */
	private MetadataSelector destination;

	/**
	 * Selector for the format for the destination data
	 */
	private DataSelector format;

	/**
	 * Selectors for the data to be formatted
	 */
	private final List<DataSelector> source = new LinkedList<DataSelector>();

	/**
	 * Applies the rule to the given data object
	 * 
	 * @param data
	 *            data to apply the rule on
	 * @see de.sub.goobi.metadaten.copier.DataCopyrule#apply(de.sub.goobi.metadaten.copier.CopierData)
	 */
	@Override
	public void apply(CopierData data) {
		String formatSequence = format.findIn(data);
		if (formatSequence == null) {
			return;
		}
		Iterable<MetadataSelector> destinations = destination.findAll(data);
		destinationLoop: for (MetadataSelector particularDestination : destinations) {
			List<String> objectStringValues = new LinkedList<String>();
			for (DataSelector objectSelector : source) {
				String value = objectSelector.findIn(new CopierData(data, particularDestination));
				if (value == null) {
					continue destinationLoop;
				}
				objectStringValues.add(value);
			}
			Object[] args = typecast(formatSequence, objectStringValues);
			particularDestination.createOrOverwrite(data, String.format(formatSequence, args));
		}
	}

	/**
	 * Returns the maximal number of objects supported by the rule to work as
	 * expected, that is unlimited.
	 * 
	 * @return Integer.MAX_VALUE
	 * @see de.sub.goobi.metadaten.copier.DataCopyrule#getMaxObjects()
	 */
	@Override
	protected int getMaxObjects() {
		return Integer.MAX_VALUE;
	}

	/**
	 * Returns the minimal number of objects required by the rule to work as
	 * expected, that is 2.
	 * 
	 * @return always 2
	 * @see de.sub.goobi.metadaten.copier.DataCopyrule#getMinObjects()
	 */
	@Override
	protected int getMinObjects() {
		return 2;
	}

	/**
	 * Saves the source object path.
	 * 
	 * @see de.sub.goobi.metadaten.copier.DataCopyrule#setObjects(java.util.List)
	 */
	@Override
	protected void setObjects(List<String> objects) throws ConfigurationException {
		Iterator<String> listOfObjects = objects.iterator();
		format = DataSelector.create(listOfObjects.next());
		do {
			source.add(DataSelector.create(listOfObjects.next()));
		} while (listOfObjects.hasNext());
	}

	/**
	 * Saves the destination object path.
	 * 
	 * @see de.sub.goobi.metadaten.copier.DataCopyrule#setSubject(java.lang.String)
	 */
	@Override
	protected void setSubject(String subject) throws ConfigurationException {
		destination = MetadataSelector.create(subject);
	}

	/**
	 * Returns a string that textually represents this copy rule.
	 * 
	 * @return a string representation of this copy rule
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return destination.toString() + ' ' + OPERATOR + ' ' + StringUtils.join(source.toArray(), ' ');
	}
}
