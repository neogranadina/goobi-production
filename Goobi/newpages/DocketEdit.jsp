<%@ page session="false" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://jsftutorials.net/htmLib" prefix="htm"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="x"%>
<%@ taglib uri="http://www.jenia.org/jsf/popup" prefix="jp"%>
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

							edit dockets

	#########################################--%>
<a4j:keepAlive beanName="DocketForm" />
<html>
<f:view locale="#{SpracheForm.locale}">
	<%@include file="inc/head.jsp"%>
	<body>
		<htm:table styleClass="headTable" cellspacing="0" cellpadding="0" style="padding-left:5px;padding-right:5px;margin-top:5px;">
			<%@include file="inc/tbl_Kopf.jsp"%>
		</htm:table>
		<htm:table cellspacing="5" cellpadding="0" styleClass="layoutTable"
			align="center">
			<htm:tr>
				<%@include file="inc/tbl_Navigation.jsp"%>
				<htm:td valign="top" styleClass="layoutInhalt">

					<%-- ++++++++++++++++     Inhalt      ++++++++++++++++ --%>
					<h:form id="ruleseteditform" onkeypress="ifEnterClick(event, 'ruleseteditform:absenden');">
						<%-- Breadcrumb --%>
						<h:panelGrid id="id0" width="100%" columns="1"
							styleClass="layoutInhaltKopf">
							<h:panelGroup id="id1">
								<h:commandLink id="id2" value="#{msgs.startseite}"
									action="newMain" />
								<f:verbatim> &#8250;&#8250; </f:verbatim>
								<h:commandLink id="id3" value="#{msgs.dockets}"
									action="RegelsaetzeAlle" />
								<f:verbatim> &#8250;&#8250; </f:verbatim>
								<h:outputText id="id4" value="#{msgs.createNewDocket}"
									rendered="#{DocketForm.myDocket.id == null}" />
								<h:outputText id="id5" value="#{msgs.editDocket}"
									rendered="#{DocketForm.myDocket.id != null}" />
							</h:panelGroup>
						</h:panelGrid>

						<htm:table border="0" align="center" width="100%" cellpadding="15">
							<htm:tr>
								<htm:td>
									<htm:h3>
										<h:outputText id="id6" value="#{msgs.createNewDocket}"
											rendered="#{DocketForm.myDocket.id == null}" />
										<h:outputText id="id7" value="#{msgs.editDocket}"
											rendered="#{DocketForm.myDocket.id != null}" />
									</htm:h3>

									<%-- globale Warn- und Fehlermeldungen --%>
									<h:messages id="id8" globalOnly="true" errorClass="text_red"
										infoClass="text_blue" showDetail="true" showSummary="true"
										tooltip="true" />

									<%-- Box für die Bearbeitung der Details --%>
									<htm:table cellpadding="3" cellspacing="0" width="100%"
										styleClass="eingabeBoxen">

										<htm:tr>
											<htm:td styleClass="eingabeBoxen_row1" align="left">
												<h:outputText id="id9" value="#{msgs.details}" />
											</htm:td>
											<htm:td styleClass="eingabeBoxen_row1" align="right">
												<h:commandLink id="id10" action="#{NavigationForm.Reload}">
													<h:graphicImage id="id11"
														value="/newpages/images/reload.gif" />
												</h:commandLink>
											</htm:td>
										</htm:tr>

										<htm:tr>
											<htm:td styleClass="eingabeBoxen_row2" colspan="2">

												<h:panelGrid id="id12" columns="2" rowClasses="top">

													<%-- Titel --%>
													<h:outputLabel id="id13" for="titel" value="#{msgs.titel}:" />
													<h:panelGroup id="id14">
														<h:inputText id="titel"
															style="width: 300px;margin-right:15px"
															value="#{DocketForm.myDocket.name}"
															required="true" />
														<x:message id="id15" for="titel" style="color: red"
															replaceIdWithLabel="true" />
													</h:panelGroup>

													<%-- Dateiname --%>
													<h:outputLabel id="id16" for="file" value="#{msgs.datei}:" />
													<h:panelGroup id="id17">
														<h:inputText id="file"
															style="width: 300px;margin-right:15px"
															value="#{DocketForm.myDocket.file}"
															required="true" />
														<x:message id="id18" for="file" style="color: red"
															replaceIdWithLabel="true" />
													</h:panelGroup>									
												</h:panelGrid>
											</htm:td>
										</htm:tr>

										<htm:tr>
											<htm:td styleClass="eingabeBoxen_row3" align="left">
												<h:commandButton id="id21" value="#{msgs.abbrechen}"
													action="DocketList" immediate="true" />
											</htm:td>
											<htm:td styleClass="eingabeBoxen_row3" align="right">
												<h:commandButton id="id22" value="#{msgs.loeschen}"
													action="#{DocketForm.Loeschen}"
													onclick="return confirm('#{msgs.sollDieserEintragWirklichGeloeschtWerden}?')"
													rendered="#{DocketForm.myDocket.id != null}" />
												<h:commandButton id="absenden" value="#{msgs.speichern}"
													action="#{DocketForm.Speichern}" />
											</htm:td>
										</htm:tr>
									</htm:table>
									<%-- // Box für die Bearbeitung der Details --%>

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
