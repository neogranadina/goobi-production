/**
 * This file is part of the Goobi Application - a Workflow tool for the support of mass digitization.
 * 
 * Visit the websites for more information. 
 *     		- http://www.goobi.org
 *     		- https://github.com/goobi/goobi-production
 * 		    - http://gdz.sub.uni-goettingen.de
 * 			- http://www.intranda.com
 * 			- http://digiverso.com 
 * 
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Linking this library statically or dynamically with other modules is making a combined work based on this library. Thus, the terms and conditions
 * of the GNU General Public License cover the whole combination. As a special exception, the copyright holders of this library give you permission to
 * link this library with independent modules to produce an executable, regardless of the license terms of these independent modules, and to copy and
 * distribute the resulting executable under terms of your choice, provided that you also meet, for each linked independent module, the terms and
 * conditions of the license of that module. An independent module is a module which is not derived from or based on this library. If you modify this
 * library, you may extend this exception to your version of the library, but you are not obliged to do so. If you do not wish to do so, delete this
 * exception statement from your version.
 */
package org.goobi.production.flow.statistics;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Locale;

import org.goobi.production.flow.statistics.enums.StatisticsMode;
import org.goobi.production.flow.statistics.hibernate.UserDefinedFilter;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.Ignore;

import de.intranda.commons.chart.results.DataTable;
import de.schlichtherle.io.File;
import de.sub.goobi.config.ConfigMain;

@Ignore("Crashes")
public class StatisticsRenderingElementTest {

	Locale locale = new Locale("GERMAN");
	IDataSource testFilter = new UserDefinedFilter("stepdone:5");
	StatisticsManager testManager = new StatisticsManager(StatisticsMode.THROUGHPUT, testFilter, locale);

	private DataTable inDataTable = new DataTable("testTable");
	private IStatisticalQuestion inQuestion = testManager.getStatisticMode().getStatisticalQuestion();
	private StatisticsRenderingElement testElement = new StatisticsRenderingElement(inDataTable, inQuestion);
	private static String tempPath;

	@BeforeClass
	public static void setUp() {
		File f = new File("pages/imagesTemp");
		tempPath = f.getAbsolutePath() + File.pathSeparator;
	}

	@Test
	public final void testStatisticsRenderingElement() {
		StatisticsRenderingElement testStatisticsRenderingElement = new StatisticsRenderingElement(inDataTable, inQuestion);
		assertNotNull(testStatisticsRenderingElement);
	}

	@Test
	public final void testCreateRenderer() {
		ConfigMain.setImagesPath(tempPath);
		testElement.createRenderer(true);

	}

	@Test
	public final void testGetDataTable() {
		assertEquals("testTable", testElement.getDataTable().getName());

	}

	@Test
	public final void testGetHtmlTableRenderer() {
		ConfigMain.setImagesPath(tempPath);
		testElement.getHtmlTableRenderer();
	}

	@Test
	public final void testGetTitle() {
		assertNotNull(testElement.getTitle());
	}

	@Test
	public final void testGetImageUrl() {
		ConfigMain.setImagesPath(tempPath);
		testElement.createRenderer(true);
		assertNotNull(testElement.getImageUrl());
	}

}
