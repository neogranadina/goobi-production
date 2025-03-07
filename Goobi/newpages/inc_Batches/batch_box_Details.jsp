<%@ page session="false" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://jsftutorials.net/htmLib" prefix="htm"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="x"%>
<%@ taglib uri="http://sourceforge.net/projects/jsf-comp/easysi" prefix="si"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%-- 
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
--%>
<htm:table cellpadding="3" cellspacing="0" style="width:100%">
	<htm:tr style="vertical-align:top">
		<htm:td>

			<h:form>
				<htm:table cellpadding="3" cellspacing="0" width="100%" styleClass="eingabeBoxen">
					<htm:tr>
						<htm:td styleClass="eingabeBoxen_row1">
							<h:outputText value="#{msgs.processesInThisBatch}" />
						</htm:td>
					</htm:tr>
					<htm:tr>
						<htm:td styleClass="eingabeBoxen_row2">
							<h:outputText value="#{msgs.showDataForProcess}: " />
							<h:selectOneMenu value="#{AktuelleSchritteForm.batchHelper.processName}">
								<si:selectItems var="process" value="#{AktuelleSchritteForm.batchHelper.processNameList}" itemLabel="#{process}" itemValue="#{process}" />
							</h:selectOneMenu>
							<h:commandButton action="#{NavigationForm.Reload}" value="#{msgs.reload}" />
						</htm:td>
					</htm:tr>
				</htm:table>
			</h:form>

			<htm:table cellpadding="3" cellspacing="0" width="100%" styleClass="main_statistikboxen" id="details">

				<htm:tr>
					<htm:td styleClass="main_statistikboxen_row1">
						<h:outputText value="#{msgs.eigenschaften}" />
					</htm:td>
				</htm:tr>

				<htm:tr>
					<htm:td styleClass="main_statistikboxen_row2">

						<htm:table border="0" width="90%" cellpadding="2">
							<htm:tr>
								<htm:td width="150">
									<h:outputText value="#{msgs.titel}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.currentStep.titelLokalisiert}" />
								</htm:td>
							</htm:tr>

							<htm:tr>
								<htm:td width="150">
									<h:outputText value="#{msgs.prozessTitel}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.processName}" />
								</htm:td>
							</htm:tr>



							<htm:tr>
								<htm:td width="150">
									<h:outputText value="#{msgs.reihenfolge}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.currentStep.reihenfolge}" />
								</htm:td>
							</htm:tr>
							<htm:tr>
								<htm:td width="150">
									<h:outputText value="#{msgs.prioritaet}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.currentStep.prioritaet}"
										rendered="#{AktuelleSchritteForm.batchHelper.currentStep.prioritaet!=10}" />
									<h:outputText value="#{msgs.korrektur}" rendered="#{AktuelleSchritteForm.batchHelper.currentStep.prioritaet==10}" />
								</htm:td>
							</htm:tr>
							<htm:tr>
								<htm:td width="150">
									<h:outputText value="#{msgs.status}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.currentStep.bearbeitungsstatusEnum.title}" />
								</htm:td>
							</htm:tr>

							<htm:tr rendered="#{AktuelleSchritteForm.batchHelper.currentStep.bearbeitungsbeginn !=null && !HelperForm.anonymized}">
								<htm:td width="150">
									<h:outputText value="#{msgs.bearbeitungsbeginn}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.currentStep.bearbeitungsbeginnAsFormattedString}" />
								</htm:td>
							</htm:tr>
							<htm:tr rendered="#{AktuelleSchritteForm.batchHelper.currentStep.bearbeitungszeitpunkt !=null && !HelperForm.anonymized}">
								<htm:td width="150">
									<h:outputText value="#{msgs.zuletztBearbeitet}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.currentStep.bearbeitungszeitpunktAsFormattedString}" />
								</htm:td>
							</htm:tr>

							<htm:tr rendered="#{AktuelleSchritteForm.batchHelper.currentStep.bearbeitungszeitpunkt !=null && !HelperForm.anonymized}">
								<htm:td width="150">
									<h:outputText value="#{msgs.aktualisierungstyp}:" />
								</htm:td>
								<htm:td>
									<h:outputText value="#{AktuelleSchritteForm.batchHelper.currentStep.editTypeEnum.title}" />
								</htm:td>
							</htm:tr>

						</htm:table>
					</htm:td>

				</htm:tr>


			</htm:table>
		</htm:td>
		<htm:td>

			<h:form id="htmleditorform">
				<h:inputText id="myTextArea" value="#{AktuelleSchritteForm.batchHelper.wikiField}" style="width: 50%" />
			</h:form>

			<h:form id="addToWikiForm" rendered="#{AktuelleSchritteForm.batchHelper.currentStep.bearbeitungsbenutzer.id == LoginForm.myBenutzer.id}">
				<h:panelGrid>
					<h:panelGroup>
						<h:inputText id="addToTextArea" value="#{AktuelleSchritteForm.batchHelper.addToWikiField}" style="width: 100%" />
					</h:panelGroup>
					<h:panelGroup>
						<h:commandButton value="#{msgs.nachrichtHinzufuegen}" action="#{AktuelleSchritteForm.batchHelper.addToWikiField}" />
						<h:commandButton value="#{msgs.nachrichtHinzufuegenForAll}" action="#{AktuelleSchritteForm.batchHelper.addToWikiFieldForAll}" />
					</h:panelGroup>
				</h:panelGrid>
			</h:form>

		</htm:td>
	</htm:tr>
</htm:table>

<script src="../js/tiny_mce/tiny_mce.js" type="text/javascript"></script>

<script type="text/javascript">
	tinyMCE
			.init({
				mode : "exact",
				elements : "htmleditorform:myTextArea",
				theme : "advanced",
				width : "100%",
				height : "200px",
				plugins : "safari,pagebreak,style,table,save,advhr,emotions,iespell,inlinepopups,insertdatetime,preview,print,contextmenu,paste,fullscreen,noneditable,visualchars,nonbreaking",
				readonly : 1,

				// Theme options
				theme_advanced_buttons1 : "save,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontsizeselect",
				theme_advanced_buttons2 : "",
				theme_advanced_buttons3 : "",
				theme_advanced_toolbar_location : "top",
				theme_advanced_toolbar_align : "left",
				theme_advanced_statusbar_location : "bottom",
				theme_advanced_resizing : true
			});
</script>
