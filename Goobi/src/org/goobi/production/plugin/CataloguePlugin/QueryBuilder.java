/**
 * This file is part of the Goobi Application - a Workflow tool for the support
 * of mass digitization.
 * 
 * (c) 2014 Goobi. Digitalisieren im Verein e.V. <contact@goobi.org>
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
package org.goobi.production.plugin.CataloguePlugin;

import java.util.List;

/**
 * The class QueryBuilder provides methods to create query strings to be passed
 * to library catalogue access plug-in implementation objects as argument to
 * their find() function. The semantics of the created query is as follows, in
 * descending precedence of the operators:
 * 
 * <p>
 * <b>Double quotes</b> (<code>""</code>) may be used to embrace a sequence of
 * tokens that have to appear in exactly that order in the search result (aka.
 * string search). They must appear in pairs.
 * </p>
 * 
 * <p>
 * <b>Round brackets</b> (<code>()</code>) may be used for logical reordering.
 * They must appear in pairs.
 * </p>
 * 
 * <p>
 * <b>Blanks</b> (<code> </code>) are used to separate tokens. They imply a
 * conjunction, i.e. <code>cat dog</code> shall return only hits that contain
 * both tokens.
 * </p>
 * 
 * <p>
 * A <b>vertical dash</b> (<code>|</code>) indicates the freedom of choice, i.e.
 * <code>cat | dog</code> may return hits that contain the token “cat” but not
 * necessarily the token “dog” and the other way round and of course hits that
 * contain both tokens as well.
 * </p>
 * 
 * <p>
 * A <b>minus sign</b> (<code>-</code>) indicates the exclusion of a search
 * term, i.e. that the hits shall not contain the given term. (Example:
 * <code>track -running</code>)<br>
 * In combination with <i>colon</i>, the minus sign shall prefix the whole
 * expression, not the search term (i.e. <code>track -4:running</code>, not
 * <code>track 4:-running</code>).
 * </p>
 * 
 * <p>
 * A <b>colon</b> (<code>:</code>) indicates fielded search, so that the term
 * must be found—or, in combination with a minus sign, must not be found—in the
 * prepended field of the database (i.e. <code>4:beagle</code> to search for the
 * term “beagle” in the field “4”). Search fields are referenced by the integers
 * used to reference them in PICA library catalogues (i.e. “4” = title, “7” =
 * ISBN, “8” = ISSN, “12” = Record identifier, …; for a list of supported fields
 * see /Goobi/newpages/NewProcess/inc_process.jsp, lines 61 et sqq.)
 * </p>
 * 
 * @author Matthias Ronge &lt;matthias.ronge@zeutschel.de&gt;
 */
public class QueryBuilder {

	/**
	 * The function appendAll() appends a list of query tokens to an initial
	 * query by means of a StringBuilder.
	 * 
	 * @param query
	 *            query to append to
	 * @param tokens
	 *            tokens to append
	 * @return complete query
	 */
	public static String appendAll(String query, List<String> tokens) {
		if (tokens.size() == 0)
			return query;
		int capacity = query.length();
		for (String token : tokens)
			capacity += token.length() + 1;
		StringBuilder result = new StringBuilder(capacity);
		result.append(query);
		for (String token : tokens) {
			result.append(' ');
			result.append(token);
		}
		return result.toString();
	}

	/**
	 * The function restrictToField() prefixes the tokens of a query by the
	 * given search field.
	 * 
	 * @param field
	 *            search field to prepend
	 * @param query
	 *            query to process
	 * @return a query whose tokens are prefixed by the given search field
	 */
	public static String restrictToField(String field, String query) {
		StringBuilder result = new StringBuilder(2 * query.length());
		String prefix = field.concat(":");
		boolean appendField = true;
		boolean stringLiteral = false;
		for (int index = 0; index < query.length(); index++) {
			int codePoint = query.charAt(index);
			switch (codePoint) {
			case ' ':
				if (!stringLiteral)
					appendField = true;
				result.appendCodePoint(codePoint);
				break;
			case '"':
				if (stringLiteral && appendField)
					result.append(prefix);
				stringLiteral = !stringLiteral;
				appendField = stringLiteral;
				result.appendCodePoint(codePoint);
				break;
			case '(':
				if (!stringLiteral)
					appendField = true;
				result.appendCodePoint(codePoint);
				break;
			case ')':
				if (!stringLiteral)
					appendField = true;
				result.appendCodePoint(codePoint);
				break;
			case '-':
				result.appendCodePoint(codePoint);
				if (appendField)
					result.append(prefix);
				appendField = false;
				break;
			case '|':
				if (!stringLiteral)
					appendField = true;
				result.appendCodePoint(codePoint);
				break;
			default:
				if (appendField)
					result.append(prefix);
				appendField = false;
				result.appendCodePoint(codePoint);
				break;
			}

		}
		return result.toString();
	}
}
