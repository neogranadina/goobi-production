<%@ page session="false" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://jsftutorials.net/htmLib" prefix="htm"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="x"%>
<%@ taglib uri="http://sourceforge.net/projects/jsf-comp/easysi" prefix="si"%>
<%@ taglib uri="http://richfaces.org/rich" prefix="rich"%>
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
<%-- ######################################## 

							Alle Aktuellen Schritte in der Übersicht

	#########################################--%>
<a4j:keepAlive beanName="BatchForm" />
<html>
<f:view locale="#{SpracheForm.locale}">
	<%@include file="inc/head.jsp"%>
	<body>
		<script type="text/javascript">
			
		<%--
		 * The function newNameBox() opens a prompt to ask the user for the name of
		 * the batch. The name is written to the hidden form field "batchName" from
		 * where it is passed to the field batchTitle in BatchForm where it can be
		 * picked up by the method createNewBatch() later. If everything is ready
		 * the function returns true. If no processes have been selected, the user
		 * is alerted and the function returns false. It will also return false if
		 * the user clicks the cancel button in the prompt opening up.
		 * 
		 * @return true if we are ready to create a batch, false otherwise
		 --%>
			function newNameBox() {
				var selectBatches = document.getElementById('mytaskform:selectProcesses');
				var size = 0;
				for (var i = 0; i < selectBatches.length; i++) {
				  if (selectBatches.options[i].selected) size++;
				}
				if(size == 0){
					alert("${msgs['noProcessSelected']}");
					return false;
				}
				var batchName = prompt("${msgs['enterBatchName']}", "");
				if(batchName != null){
					document.getElementById('mytaskform:batchName').value = batchName;
					return true;
				}else{
					return false;
				}
			}
		<%--
		 * The function renameBox() opens a prompt to ask the user for the new name
		 * of the batch. The new name is written to the hidden form field
		 * "batchName" from where it is passed to the field batchTitle in BatchForm
		 * where it can be picked up by the method renameBatch() later. If
		 * everything is ready the function returns true. If none or several batches
		 * have been selected, the user is alerted and the function returns false.
		 * It will also return false if the user clicks the cancel button in the
		 * prompt opening up.
		 * 
		 * @return true if we are ready to rename, false otherwise
		 --%>
			function renameBox() {
				var selectBatches = document.getElementById('mytaskform:selectBatches');
				var size = 0;
				for (var i = 0; i < selectBatches.length; i++) {
				  if (selectBatches.options[i].selected) size++;
				}
				if(size == 0){
					alert("${msgs['noBatchSelected']}");
					return false;
				}
				if(size > 1){
					alert("${msgs['tooManyBatchesSelected']}");
					return false;
				}
				var text = selectBatches.options[selectBatches.selectedIndex].text;
				var newName = prompt("${msgs['enterBatchName']}", text.replace(/ \[.*?\]$/, "").replace(/ \(.*?\)$/, ""));
				if(newName != null){
					document.getElementById('mytaskform:batchName').value = newName;
					return true;
				}else{
					return false;
				}
			}
		</script>

		<htm:table styleClass="headTable" cellspacing="0" cellpadding="0" style="padding-left:5px;padding-right:5px;margin-top:5px;">
			<%@include file="inc/tbl_Kopf.jsp"%>
			</htm:table>
		<htm:table cellspacing="5" cellpadding="0" styleClass="layoutTable"
			align="center">
			<htm:tr>
				<%@include file="inc/tbl_Navigation.jsp"%>
				<htm:td valign="top" styleClass="layoutInhalt">

					<%-- ++++++++++++++++     Inhalt      ++++++++++++++++ --%>
					<h:form id="mytaskform" rendered="#{((LoginForm.maximaleBerechtigung == 1) || (LoginForm.maximaleBerechtigung == 2))}">
						<%-- Breadcrumb --%>
						<h:panelGrid id="id0" width="100%" columns="1" styleClass="layoutInhaltKopf">
							<h:panelGroup id="id1">
								<h:commandLink id="id2" value="#{msgs.startseite}" action="newMain" />
								<f:verbatim> &#8250;&#8250; </f:verbatim>
								<h:outputText id="id3" value="#{msgs.batches}" />
							</h:panelGroup>
						</h:panelGrid>

						<htm:table border="0" align="center" width="100%" cellpadding="15">
							<htm:tr>
								<htm:td>

									<%-- Ueberschrift --%>
									<htm:h3>
										<h:outputText id="id4" value="#{msgs.batches}" />
									</htm:h3>

									<%-- globale Warn- und Fehlermeldungen --%>
									<h:messages id="id5" globalOnly="true" errorClass="text_red" infoClass="text_blue" showDetail="true" showSummary="true" tooltip="true" />

									<htm:table cellpadding="3" cellspacing="0" width="100%" styleClass="eingabeBoxen">
										<htm:tr>
											<htm:td colspan="2" styleClass="eingabeBoxen_row1">
												<h:outputText value="#{msgs.auswahl}" />
											</htm:td>
										</htm:tr>
										<htm:tr>
											<htm:td width="50%" styleClass="eingabeBoxen_row2" style="padding-left: 20px;vertical-align:top;">
											
												<htm:h4>
													<h:outputText value="#{msgs.batches}" />
												</htm:h4>
												
												<h:panelGroup style="margin-bottom:10px;display:block;" >
													<h:inputText value="#{BatchForm.batchfilter}" style="width:350px"/>
													<h:commandButton action="#{BatchForm.filterBatches}" title="#{msgs.filter}" value="#{msgs.filter}" />
												</h:panelGroup>
												
												<h:selectManyListbox value="#{BatchForm.selectedBatches}" style="width:90%;margin-bottom:10px;display:block;" size="20" id="selectBatches">
													<si:selectItems var="batch" value="#{BatchForm.currentBatches}" itemLabel="#{batch}" itemValue="#{batch.idString}" />
												</h:selectManyListbox>
									
												<h:panelGrid columns="1" cellpadding="2px">
													<h:commandLink action="#{BatchForm.exportBatch}">
														<h:graphicImage alt="reload" value="/newpages/images/buttons/dms.png" style="vertical-align:middle" />
														<h:outputText value="#{msgs.exportBatch}" />
													</h:commandLink>
													
													<h:panelGroup>
														<h:graphicImage alt="new" value="/newpages/images/buttons/edit.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.typeSet}" />
														<h:outputText value=" " />
														<h:commandLink action="#{BatchForm.setLogistic}">
															<h:outputText value="#{msgs.typeSetLogistic}" />
														</h:commandLink>
														<h:outputText value=", " />
														<h:commandLink action="#{BatchForm.setNewspaper}">
															<h:outputText value="#{msgs.typeSetNewspaper}" />
														</h:commandLink>
														<h:outputText value=", " />
														<h:commandLink action="#{BatchForm.setSerial}">
															<h:outputText value="#{msgs.typeSetSerial}" />
														</h:commandLink>
													</h:panelGroup>

													<h:commandLink action="#{BatchForm.loadProcessData}">
														<h:graphicImage alt="reload" value="/newpages/images/buttons/reload_doc.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.loadProcessesOfBatch}" />
													</h:commandLink>
										
													<h:commandLink action="#{BatchForm.filterProcesses}">
														<h:graphicImage alt="reload" value="/newpages/images/buttons/reload_doc.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.loadAllProcesses}" />
													</h:commandLink>
										
													<h:commandLink action="#{BatchForm.downloadDocket}">
														<h:graphicImage alt="/newpages/images/buttons/laufzettel_wide.png" value="/newpages/images/buttons/laufzettel_wide.png"
															style="vertical-align:middle" />
														<h:outputText value="#{msgs.laufzettelDrucken}" />
													</h:commandLink>
										
													<h:commandLink action="#{BatchForm.editProperties}">
														<h:graphicImage  alt="edit" value="/newpages/images/buttons/edit.gif" style="vertical-align:middle"  />
														<h:outputText value="#{msgs.eigenschaftBearbeiten}"/>
													</h:commandLink>

													<h:commandLink action="#{BatchForm.deleteBatch}" style="margin-left:7px;">
														<h:graphicImage alt="deleteBatch" value="/newpages/images/buttons/waste1a_20px.gif" style="vertical-align:middle;margin-right:7px" />
														<h:outputText value="#{msgs.deleteBatch}" />
													</h:commandLink>
										
												</h:panelGrid>					
											</htm:td>
											
											<htm:td width="50%" styleClass="eingabeBoxen_row2" style="padding-left: 20px;vertical-align:top;">
												<htm:h4>
													<h:outputText value="#{msgs.prozesse}" />
												</htm:h4>
												
												<h:panelGroup style="margin-bottom:10px;display:block;" >
													<h:inputText value="#{BatchForm.processfilter}" style="width:350px" />
													<h:commandButton action="#{BatchForm.filterProcesses}" value="#{msgs.filter}" title="#{msgs.filter}" />
												</h:panelGroup>
												
												<h:selectManyListbox value="#{BatchForm.selectedProcesses}" converter="ProcessConverter"  style="width:90%;margin-bottom:10px;display:block;" size="20" id="selectProcesses">
													<f:selectItems value="#{BatchForm.currentProcessesAsSelectItems}" />
												</h:selectManyListbox>
								
												<h:panelGrid columns="1" cellpadding="2px">
													<h:commandLink action="#{BatchForm.loadBatchData}">
														<h:graphicImage alt="reload" value="/newpages/images/buttons/reload_doc.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.loadAssociatedBatchOfProcess}" />
													</h:commandLink>
									
													<h:commandLink action="#{BatchForm.addProcessesToBatch}">
														<h:graphicImage alt="add" value="/newpages/images/buttons/ok.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.addToSelectedBatch}" />
													</h:commandLink>
									
													<h:commandLink action="#{BatchForm.removeProcessesFromBatch}">
														<h:graphicImage alt="remove" value="/newpages/images/buttons/cancel1.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.removeFromAssociatedBatch}" />
													</h:commandLink>
													
													<h:inputHidden value="#{BatchForm.batchName}" id="batchName" />
													<h:commandLink action="#{BatchForm.renameBatch}" onclick="if(!renameBox())return false">
														<h:graphicImage alt="new" value="/newpages/images/buttons/edit.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.renameBatch}" />
													</h:commandLink>
													
													<h:commandLink action="#{BatchForm.createNewBatch}" onclick="if(!newNameBox())return false">
														<h:graphicImage alt="new" value="/newpages/images/buttons/star_blue.gif" style="vertical-align:middle" />
														<h:outputText value="#{msgs.createNewBatchFromSelectedProcesses}" />
													</h:commandLink>
												</h:panelGrid>
											</htm:td>
										</htm:tr>
								
									</htm:table>

								</htm:td>
							</htm:tr>
						</htm:table>
					</h:form>
					<%-- ++++++++++++++++    // Inhalt      ++++++++++++++++ --%>
				</htm:td>
			</htm:tr>
			<%@include file="inc/tbl_Fuss.jsp"%>
		</htm:table>

	</body>

</f:view>

</html>
