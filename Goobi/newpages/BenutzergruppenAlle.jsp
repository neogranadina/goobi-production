<%@ page session="false" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://jsftutorials.net/htmLib" prefix="htm"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="x"%>
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

							Alle Benutzer in der Übersicht

	#########################################--%>
<a4j:keepAlive beanName="BenutzergruppenForm" />
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
					<h:form id="groupform">
						<%-- Breadcrumb --%>
						<h:panelGrid id="id0" columns="1" styleClass="layoutInhaltKopf">
							<h:panelGroup id="id1">
								<h:commandLink id="id2" value="#{msgs.startseite}"
									action="newMain" />
								<f:verbatim> &#8250;&#8250; </f:verbatim>
								<h:outputText id="id3" value="#{msgs.benutzergruppen}" />
							</h:panelGroup>
						</h:panelGrid>

						<htm:table border="0" align="center" width="100%" cellpadding="15">
							<htm:tr>
								<htm:td>

									<%-- Überschrift --%>
									<htm:h3>
										<h:outputText id="id4" value="#{msgs.benutzergruppen}" />
									</htm:h3>

									<%-- Neu-Schaltknopf --%>
									<h:commandLink id="id5" action="#{BenutzergruppenForm.Neu}"
										immediate="true"
										rendered="#{(LoginForm.maximaleBerechtigung == 1) || (LoginForm.maximaleBerechtigung == 2)}">
										<h:outputText id="id6"
											value="#{msgs.neueBenutzergruppeAnlegen}" />
									</h:commandLink>

									<%-- globale Warn- und Fehlermeldungen --%>
									<h:messages id="id7" globalOnly="true" errorClass="text_red"
										infoClass="text_blue" showDetail="true" showSummary="true"
										tooltip="true" />

									<%-- Datentabelle --%>
									<x:dataTable id="auflistung" styleClass="standardTable"
										width="100%" cellspacing="1px" cellpadding="1px"
										headerClass="standardTable_Header"
										rowClasses="standardTable_Row1,standardTable_Row2"
										columnClasses="standardTable_Column,standardTable_ColumnCentered"
										var="item" value="#{BenutzergruppenForm.page.listReload}" style="margin-top: 10px;">

										<h:column id="id8">
											<f:facet name="header">
												<h:outputText id="id9" value="#{msgs.benutzergruppe}" />
											</f:facet>

											<jsp:include page="/newpages/inc/ajaxPlusMinusButton.jsp" />
											<x:dataTable id="id11" styleClass="standardTable" width="90%"
												style="margin-left:12px;margin-top:5px" cellspacing="1px"
												cellpadding="1px" headerClass="standardTable_Header"
												rowClasses="standardTable_Row1"
												rendered="#{item.panelAusgeklappt}"
												columnClasses="standardTable_ColumnSchmal,standardTable_Column,standardTable_ColumnCentered"
												var="step" value="#{item.benutzerList}">
												<h:column id="id12">
													<f:facet name="header">
														<h:outputText id="id13" value="#{msgs.benutzer}" />
													</f:facet>
													<h:outputText id="id14" value="#{step.nachVorname}" />
												</h:column>
											</x:dataTable>
										</h:column>

										<h:column
											rendered="#{(LoginForm.maximaleBerechtigung == 1) || (LoginForm.maximaleBerechtigung == 2)}">
											<f:facet name="header">
												<h:outputText id="id15" value="#{msgs.auswahl}" />
											</f:facet>
											<%-- Bearbeiten-Schaltknopf --%>
											<h:commandLink id="id16" action="BenutzergruppenBearbeiten"
												title="#{msgs.benutzerBearbeiten}">
												<h:graphicImage id="id17"
													value="/newpages/images/buttons/edit.gif" />
												<x:updateActionListener
													property="#{BenutzergruppenForm.myBenutzergruppe}"
													value="#{item}" />
											</h:commandLink>
										</h:column>

									</x:dataTable>
									
									<%-- Neu-Schaltknopf --%>
									<h:commandLink id="id52" action="#{BenutzergruppenForm.Neu}"
										immediate="true"
										rendered="#{((LoginForm.maximaleBerechtigung == 1) || (LoginForm.maximaleBerechtigung == 2)) && (BenutzergruppenForm.page.totalResults > LoginForm.myBenutzer.tabellengroesse)}" 

										>
										<h:outputText id="id62"
											value="#{msgs.neueBenutzergruppeAnlegen}" />
									</h:commandLink>
									<htm:table width="100%" border="0">
										<htm:tr valign="top">
											<htm:td align="left">

											</htm:td>
											<htm:td align="center">
												<%-- ===================== Datascroller für die Ergebnisse ====================== --%>

												<x:aliasBean alias="#{mypage}"
													value="#{BenutzergruppenForm.page}">
													<jsp:include page="/newpages/inc/datascroller.jsp" />
												</x:aliasBean>
												<%-- ===================== // Datascroller für die Ergebnisse ====================== --%>
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
