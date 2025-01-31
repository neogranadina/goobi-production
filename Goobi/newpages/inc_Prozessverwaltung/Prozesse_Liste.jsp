<%@ page session="false" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://jsftutorials.net/htmLib" prefix="htm"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="x"%>
<%@ taglib uri="http://www.jenia.org/jsf/dynamic" prefix="jd"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://richfaces.org/rich" prefix="rich"%>
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
<style>
.cur {
	cursor: pointer;
}

.top {
	vertical-align: top;
}
</style>

<a4j:loadBundle basename="messages.messages" var="msgs" />

<htm:h4>
	<h:outputText value="#{msgs.prozessvorlagen}" rendered="#{ProzessverwaltungForm.modusAnzeige=='vorlagen'}" />
	<h:outputText value="#{msgs.aktuelleProzesse}" rendered="#{ProzessverwaltungForm.modusAnzeige=='aktuell'}" />
</htm:h4>

<%-- Neu-Schaltknopf --%>
<h:commandLink action="#{ProzessverwaltungForm.Neu}" immediate="true"
	rendered="#{(LoginForm.maximaleBerechtigung == 1 || LoginForm.maximaleBerechtigung == 2) && ProzessverwaltungForm.modusAnzeige!='vorlagen'}"
	id="new1">
	<h:outputText value="#{msgs.einenNeuenProzessAnlegen}" />
</h:commandLink>

<%-- Neu-Schaltknopf --%>
<h:commandLink action="#{ProzessverwaltungForm.NeuVorlage}" immediate="true"
	rendered="#{(LoginForm.maximaleBerechtigung == 1 || LoginForm.maximaleBerechtigung == 2) && ProzessverwaltungForm.modusAnzeige=='vorlagen'}"
	id="new2">
	<h:outputText value="#{msgs.eineNeueProzessvorlageAnlegen}" />
</h:commandLink>


<%-- +++++++++++++++++  Anzeigefilter ++++++++++++++++++++++++ --%>
<x:aliasBeansScope>
	<x:aliasBean alias="#{Form}" value="#{ProzessverwaltungForm}" />
	<x:aliasBean alias="#{showHits}" value="#{true}" />
	<f:subview id="sub1">
		<jsp:include page="/newpages/inc/Process_Filter.jsp" />
	</f:subview>
</x:aliasBeansScope>


<%-- Datentabelle --%>
<x:dataTable id="auflistung" styleClass="standardTable" width="100%" cellspacing="1px" cellpadding="1px" headerClass="standardTable_Header"
	rowClasses="standardTable_Row1,standardTable_Row2,standardTable_Row1,standardTable_Row2" var="item" value="#{ProzessverwaltungForm.page.listReload}">

	<%-- +++++++++++++++++  SelectionBoxes ++++++++++++++++++++++++ --%>
	<x:column style="text-align:center"
		rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && ProzessverwaltungForm.anzeigeAnpassen['selectionBoxes']}">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:outputText value="#{msgs.auswahl2}" />
				<h:commandLink action="#{ProzessverwaltungForm.SelectionAll}" id="selectall" title="#{msgs.alleAuswaehlen}" style="margin-left:10px">
					<h:graphicImage value="/newpages/images/check_true.gif" />
				</h:commandLink>
				<h:commandLink action="#{ProzessverwaltungForm.SelectionNone}" id="selectnone" title="#{msgs.auswahlEntfernen}" style="margin-left:5px">
					<h:graphicImage value="/newpages/images/check_false.gif" />
				</h:commandLink>
			</x:div>
		</f:facet>
		<a4j:commandLink reRender="myself1" id="myself1">
			<h:graphicImage value="/newpages/images/check_true.gif" style="margin-right:4px" rendered="#{item.selected}" />
			<h:graphicImage value="/newpages/images/check_false.gif" style="margin-right:4px" rendered="#{!item.selected}" />
			<x:updateActionListener value="#{item.selected?false:true}" property="#{item.selected}" />
			<a4j:ajaxListener type="org.ajax4jsf.ajax.ForceRender" />
		</a4j:commandLink>
	</x:column>

	<%-- +++++++++++++++++  ProzessID ++++++++++++++++++++++++ --%>
	<x:column style="text-align:center" rendered="#{ProzessverwaltungForm.anzeigeAnpassen['processId']}">
		<f:facet name="header">
			<h:outputText value="#{msgs.id}" />
		</f:facet>
		<h:outputText value="#{item.id}" />
	</x:column>

	<%-- +++++++++++++++++  BatchID ++++++++++++++++++++++++ --%>
	<x:column style="text-align:center" rendered="#{ProzessverwaltungForm.anzeigeAnpassen['batchId']}">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:outputText value="#{msgs.batch}" />
				<%-- Sortierung Asc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort13a" rendered="#{ProzessverwaltungForm.sortierung=='batchAsc'}">
					<h:graphicImage value="/newpages/images/sorting/asc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="batchDesc" />
				</h:commandLink>
				<%-- Sortierung Desc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort14a" rendered="#{ProzessverwaltungForm.sortierung=='batchDesc'}">
					<h:graphicImage value="/newpages/images/sorting/desc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="batchAsc" />
				</h:commandLink>
				<%-- Sortierung none --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort15a"
					rendered="#{ProzessverwaltungForm.sortierung!='batchDesc' && ProzessverwaltungForm.sortierung!='batchAsc'}">
					<h:graphicImage value="/newpages/images/sorting/none.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="batchAsc" />
				</h:commandLink>
			</x:div>
		</f:facet>
		<h:outputText value="#{item.batchID}" rendered="#{item.batchID != null}" />
	</x:column>

	<%-- +++++++++++++++++  alle Schritte auflisten mit Ajax ++++++++++++++++++++++++ --%>
	<x:column rendered="true" id="ajaxcolumn" style="text-align:left">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:panelGroup>
					<h:outputText value="#{msgs.prozessvorlagen}" rendered="#{ProzessverwaltungForm.modusAnzeige=='vorlagen'}" />
					<h:outputText value="#{msgs.prozessTitel}" rendered="#{ProzessverwaltungForm.modusAnzeige=='aktuell'}" />
				</h:panelGroup>

				<%-- Sortierung Asc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort1" rendered="#{ProzessverwaltungForm.sortierung=='titelAsc'}">
					<h:graphicImage value="/newpages/images/sorting/asc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="titelDesc" />
				</h:commandLink>
				<%-- Sortierung Desc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort2" rendered="#{ProzessverwaltungForm.sortierung=='titelDesc'}">
					<h:graphicImage value="/newpages/images/sorting/desc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="titelAsc" />
				</h:commandLink>
				<%-- Sortierung none --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort3"
					rendered="#{ProzessverwaltungForm.sortierung!='titelDesc' && ProzessverwaltungForm.sortierung!='titelAsc'}">
					<h:graphicImage value="/newpages/images/sorting/none.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="titelAsc" />
				</h:commandLink>
			</x:div>
		</f:facet>

		<a4j:commandLink reRender="auflistungIntern,myself" id="myself" style="color:black">
			<h:graphicImage value="/newpages/images/plus.gif" style="margin-right:4px" rendered="#{!item.panelAusgeklappt}" />
			<h:graphicImage value="/newpages/images/minus.gif" style="margin-right:4px" rendered="#{item.panelAusgeklappt}" />
			<x:updateActionListener value="#{item.panelAusgeklappt?false:true}" property="#{item.panelAusgeklappt}" />
			<h:outputText value="#{item.titel}" />
			<a4j:ajaxListener type="org.ajax4jsf.ajax.ForceRender" />
		</a4j:commandLink>

		<h:panelGroup id="auflistungIntern">
			<x:dataTable id="prozessdetails" styleClass="standardTable" width="90%" style="margin-left:12px;margin-top:5px" cellspacing="1px" cellpadding="1px"
				headerClass="standardTable_Header" rowClasses="standardTable_Row1" rendered="#{item.panelAusgeklappt}"
				columnClasses="standardTable_ColumnSchmal,standardTable_Column,standardTable_ColumnCentered" var="step" value="#{item.schritteList}">

				<h:column>
					<f:facet name="header">
						<h:outputText value="#{msgs.nr}" />
					</f:facet>
					<h:outputText value="#{step.reihenfolge}" />
				</h:column>

				<h:column>
					<f:facet name="header">
						<h:outputText value="#{msgs.titel}" />
					</f:facet>
					<h:outputText value="#{step.titelLokalisiert}" />
				</h:column>

				<h:column>
					<f:facet name="header">
						<h:outputText value="#{msgs.status}" />
					</f:facet>
					<h:graphicImage value="#{step.bearbeitungsstatusEnum.smallImagePath}" title="#{step.bearbeitungsstatusEnum.title}"
						rendered="#{step.bearbeitungsstatusEnum == 'OPEN' || step.bearbeitungsstatusEnum == 'LOCKED'}" />
					<h:graphicImage value="#{step.bearbeitungsstatusEnum.smallImagePath}"
						title="#{step.bearbeitungsstatusEnum.title}: #{step.bearbeitungsbenutzer!=null && step.bearbeitungsbenutzer.id!=0?step.bearbeitungsbenutzer.nachVorname:''} (#{step.bearbeitungszeitpunkt !=null?step.bearbeitungszeitpunktAsFormattedString:''})  - #{step.editTypeEnum.title}"
						rendered="#{(step.bearbeitungsstatusEnum == 'DONE' || step.bearbeitungsstatusEnum == 'INWORK') && !HelperForm.anonymized}" />
					<h:graphicImage value="#{step.bearbeitungsstatusEnum.smallImagePath}" title="#{step.bearbeitungsstatusEnum.title}: #{step.editTypeEnum.title}"
						rendered="#{(step.bearbeitungsstatusEnum == 'DONE' || step.bearbeitungsstatusEnum == 'INWORK') && HelperForm.anonymized}" />
				</h:column>

			</x:dataTable>
		</h:panelGroup>
	</x:column>
	<%-- +++++++++++++++++  // alle Schritte auflisten mit Ajax ++++++++++++++++++++++++ --%>

	<%-- +++++++++++++++++  Vorgangsdatum ++++++++++++++++++++++++ --%>
	<x:column style="text-align:center" rendered="#{ProzessverwaltungForm.anzeigeAnpassen['processDate']}">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:outputText value="#{msgs.vorgangsdatum}" />
				<%-- Sortierung Asc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort4" rendered="#{ProzessverwaltungForm.sortierung=='vorgangsdatumAsc'}">
					<h:graphicImage value="/newpages/images/sorting/asc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="vorgangsdatumDesc" />
				</h:commandLink>
				<%-- Sortierung Desc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort5" rendered="#{ProzessverwaltungForm.sortierung=='vorgangsdatumDesc'}">
					<h:graphicImage value="/newpages/images/sorting/desc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="vorgangsdatumAsc" />
				</h:commandLink>
				<%-- Sortierung none --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort6"
					rendered="#{ProzessverwaltungForm.sortierung!='vorgangsdatumDesc' && ProzessverwaltungForm.sortierung!='vorgangsdatumAsc'}">
					<h:graphicImage value="/newpages/images/sorting/none.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="vorgangsdatumAsc" />
				</h:commandLink>
			</x:div>


		</f:facet>
		<h:outputText value="#{item.erstellungsdatum}" />
	</x:column>

	<%-- +++++++++++++++++  Status ++++++++++++++++++++++++ --%>
	<x:column style="text-align:center">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:outputText value="#{msgs.status}" />
				<%-- Sortierung Asc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort7" rendered="#{ProzessverwaltungForm.sortierung=='fortschrittAsc'}">
					<h:graphicImage value="/newpages/images/sorting/asc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="fortschrittDesc" />
				</h:commandLink>
				<%-- Sortierung Desc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort8" rendered="#{ProzessverwaltungForm.sortierung=='fortschrittDesc'}">
					<h:graphicImage value="/newpages/images/sorting/desc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="fortschrittAsc" />
				</h:commandLink>
				<%-- Sortierung none --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort9"
					rendered="#{ProzessverwaltungForm.sortierung!='fortschrittDesc' && ProzessverwaltungForm.sortierung!='fortschrittAsc'}">
					<h:graphicImage value="/newpages/images/sorting/none.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="fortschrittAsc" />
				</h:commandLink>
			</x:div>
		</f:facet>
		<h:graphicImage value="/newpages/images/fortschritt/ende_links.gif" rendered="true" />
		<h:graphicImage value="/newpages/images/fortschritt/gr.gif" style="width:#{item.fortschritt3 * 0.8}px;height:10px" />
		<h:graphicImage value="/newpages/images/fortschritt/ge.gif" style="width:#{item.fortschritt2 * 0.8}px;height:10px" />
		<h:graphicImage value="/newpages/images/fortschritt/rt.gif" style="width:#{item.fortschritt1 * 0.8}px;height:10px" />
		<h:graphicImage value="/newpages/images/fortschritt/ende_rechts.gif" rendered="true" />
	</x:column>

	<x:column style="text-align:center">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:outputText value="#{msgs.projekt}" />
				<%-- Sortierung Asc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort10" rendered="#{ProzessverwaltungForm.sortierung=='projektAsc'}">
					<h:graphicImage value="/newpages/images/sorting/asc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="projektDesc" />
				</h:commandLink>
				<%-- Sortierung Desc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort11" rendered="#{ProzessverwaltungForm.sortierung=='projektDesc'}">
					<h:graphicImage value="/newpages/images/sorting/desc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="projektAsc" />
				</h:commandLink>
				<%-- Sortierung none --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort12"
					rendered="#{ProzessverwaltungForm.sortierung!='projektDesc' && ProzessverwaltungForm.sortierung!='projektAsc'}">
					<h:graphicImage value="/newpages/images/sorting/none.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="projektAsc" />
				</h:commandLink>
			</x:div>
		</f:facet>
		<h:outputText value="#{item.projekt.titel}" />
	</x:column>

	<x:column style="text-align:center" rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && ProzessverwaltungForm.anzeigeAnpassen['lockings']}">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:outputText value="#{msgs.sperrungen}" />
				<%-- Sortierung Asc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort13" rendered="#{ProzessverwaltungForm.sortierung=='sperrungenAsc'}">
					<h:graphicImage value="/newpages/images/sorting/asc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="sperrungenDesc" />
				</h:commandLink>
				<%-- Sortierung Desc --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort14" rendered="#{ProzessverwaltungForm.sortierung=='sperrungenDesc'}">
					<h:graphicImage value="/newpages/images/sorting/desc.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="sperrungenAsc" />
				</h:commandLink>
				<%-- Sortierung none --%>
				<h:commandLink action="#{ProzessverwaltungForm.FilterAlleStart}" id="sort15"
					rendered="#{ProzessverwaltungForm.sortierung!='sperrungenDesc' && ProzessverwaltungForm.sortierung!='sperrungenAsc'}">
					<h:graphicImage value="/newpages/images/sorting/none.gif" style="vertical-align:middle;margin-left:5px" />
					<x:updateActionListener property="#{ProzessverwaltungForm.sortierung}" value="sperrungenAsc" />
				</h:commandLink>
			</x:div>
		</f:facet>
		<h:outputText value="#{item.benutzerGesperrt.nachVorname}" rendered="#{item.benutzerGesperrt != null}" />
	</x:column>

	<%-- +++++++++++++++++  Swapped out ++++++++++++++++++++++++ --%>
	<x:column style="text-align:center"
		rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && ProzessverwaltungForm.anzeigeAnpassen['swappedOut']}">
		<f:facet name="header">
			<x:div>
				<%-- Header --%>
				<h:outputText value="#{msgs.ausgelagert}" />
			</x:div>
		</f:facet>
		<h:graphicImage value="/newpages/images/check_true.gif" rendered="#{item.swappedOutGui}" />
		<h:graphicImage value="/newpages/images/check_false.gif" rendered="#{!item.swappedOutGui}" />
	</x:column>

	<x:column style="text-align:center" width="223px" styleClass="action">
		<f:facet name="header">
			<h:outputText value="#{msgs.auswahl}" styleClass="action" />
		</f:facet>

		<%-- Bearbeiten-Schaltknopf: konkrete Prozesse --%>
		<h:commandLink action="#{ProzessverwaltungForm.editProcess}" id="action10" rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen'}"
			title="#{msgs.prozessBearbeiten}">
			<h:graphicImage value="/newpages/images/buttons/goInto.gif" style="margin-right:5px" />
			<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			<x:updateActionListener property="#{ProzessverwaltungForm.modusBearbeiten}" value="" />
		</h:commandLink>

		<%-- Bearbeiten-Schaltknopf: Vorlagen --%>
		<h:commandLink action="#{ProzessverwaltungForm.editProcess}" id="action11"
			rendered="#{(LoginForm.maximaleBerechtigung == 1) && (ProzessverwaltungForm.modusAnzeige=='vorlagen')}" title="#{msgs.prozessBearbeiten}">
			<h:graphicImage value="/newpages/images/buttons/goInto.gif" style="margin-right:5px" />
			<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			<x:updateActionListener property="#{ProzessverwaltungForm.modusBearbeiten}" value="" />
		</h:commandLink>

		<%-- tif-Header-Schaltknopf --%>
		<h:commandLink action="#{ProzessverwaltungForm.DownloadTiffHeader}" id="action12" title="#{msgs.dateiMitTiffHeaderSpeichern}"
			rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && 0==1}">
			<h:graphicImage value="/newpages/images/buttons/tif.gif" style="margin-right:1px" />
			<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
		</h:commandLink>

		<%-- Multi-Tiff-Export-Schaltknopf --%>
		<h:commandLink action="#{ProzessverwaltungForm.DownloadMultiTiff}" id="action13" title="#{msgs.multiTiffDownloaden}"
			rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && LoginForm.maximaleBerechtigung == 1 && 0==1}">
			<h:graphicImage value="/newpages/images/buttons/view3.gif" style="margin-right:3px" />
			<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
		</h:commandLink>

		<%-- Metadaten-Schaltknopf --%>
		<h:commandLink action="#{Metadaten.XMLlesen}" id="action14" title="#{msgs.metadatenBearbeiten}123"
			rendered="#{(LoginForm.maximaleBerechtigung != 1) && (LoginForm.maximaleBerechtigung != 2) && item.benutzerGesperrt == null && ProzessverwaltungForm.modusAnzeige!='vorlagen'}">
			<h:graphicImage value="/newpages/images/buttons/view1.gif" style="margin-right:10px" />
			<f:param name="nurLesen" value="true" />
			<f:param name="ProzesseID" value="#{item.id}" />
			<f:param name="BenutzerID" value="#{LoginForm.myBenutzer.id}" />
			<f:param name="zurueck" value="ProzessverwaltungAlle" />
		</h:commandLink>

		<h:panelGroup rendered="#{(LoginForm.maximaleBerechtigung == 1) || (LoginForm.maximaleBerechtigung == 2)}">

			<%-- Metadaten-Schaltknopf --%>
			<h:commandLink action="#{Metadaten.XMLlesen}" id="action15" title="#{msgs.metadatenBearbeiten}"
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen'}">
				<h:graphicImage value="/newpages/images/buttons/view1.gif" style="margin-right:10px" />
				<f:param name="ProzesseID" value="#{item.id}" />
				<f:param name="BenutzerID" value="#{LoginForm.myBenutzer.id}" />
				<f:param name="zurueck" value="ProzessverwaltungAlle" />
			</h:commandLink>

			<%-- Download-Schaltknopf --%>
			<h:commandLink action="#{ProzessverwaltungForm.DownloadToHome}" id="action16" title="#{msgs.imHomeVerzeichnisVerlinken}"
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && !item.imageFolderInUse}">
				<h:graphicImage value="/newpages/images/buttons/load_down2.gif" style="margin-right:2px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>

			<%-- Download-Schaltknopf --%>
			<h:commandLink action="#{ProzessverwaltungForm.DownloadToHome}" id="action17" title="#{msgs.imHomeVerzeichnisVerlinkenTrotzBearbeitung}"
				onclick="if (!confirm('#{msgs.warningAdminBeforeLinking}')) return"
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && item.imageFolderInUse}">
				<h:graphicImage value="/newpages/images/buttons/load_down3.gif" style="margin-right:2px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>

			<%-- Upload-Schaltknopf --%>
			<h:commandLink action="#{ProzessverwaltungForm.UploadFromHome}" id="action18" title="#{msgs.ausHomeverzeichnisEntfernen}"
				onclick="if (!confirm('#{msgs.ausHomeverzeichnisEntfernen}?')) return" rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen'}">
				<h:graphicImage value="/newpages/images/buttons/load_up2.gif" style="margin-right:2px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>

			<%-- XML Export-Schaltknopf --%>
			<h:commandLink id="ubid119" action="#{ProzessverwaltungForm.CreateXML}" title="#{msgs.createXML}"
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen'}">
				<h:graphicImage id="ubid120" alt="sorta" value="/newpages/images/buttons/xml.gif" style="margin-right:2px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>

			<%-- Docket Export --%>
			<h:commandLink id="ubid1119" action="#{ProzessverwaltungForm.downloadDocket}" title="#{msgs.laufzettelDrucken}"
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen'}">
				<h:graphicImage id="ubid1120" alt="sorta" value="/newpages/images/buttons/laufzettel.png" style="margin-right:2px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>


			<%-- Mets-Export-Schaltknopf --%>
			<h:commandLink action="#{ProzessverwaltungForm.ExportMets}" id="action19" title="#{msgs.exportMets}"
				rendered="#{(ProzessverwaltungForm.modusAnzeige!='vorlagen' && (LoginForm.maximaleBerechtigung == 2 || LoginForm.maximaleBerechtigung == 1)) && item.tifDirectoryExists}">
				<h:graphicImage value="/newpages/images/buttons/mets.png" style="margin-right:2px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>

			<%-- Mets-Export-Schaltknopf greyed --%>
			<h:graphicImage
				rendered="#{(ProzessverwaltungForm.modusAnzeige!='vorlagen' && (LoginForm.maximaleBerechtigung == 2 || LoginForm.maximaleBerechtigung == 1)) && !item.tifDirectoryExists}"
				value="/newpages/images/buttons/metsGreyed.png" style="margin-right:2px" title="#{msgs.exportMets}" />

			<%-- PDF-Export-Schaltknopf --%>
			<h:commandLink action="#{ProzessverwaltungForm.ExportPdf}" id="action20" title="#{msgs.exportPdf}"
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && (LoginForm.maximaleBerechtigung == 2 || LoginForm.maximaleBerechtigung == 1) && item.tifDirectoryExists}">
				<h:graphicImage value="/newpages/images/buttons/pdf.png" style="margin-right:2px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>

			<%-- PDF-Export-Schaltknopf greyed --%>
			<h:graphicImage
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && (LoginForm.maximaleBerechtigung == 2 || LoginForm.maximaleBerechtigung == 1) && !item.tifDirectoryExists}"
				value="/newpages/images/buttons/pdfGreyed.png" style="margin-right:2px" title="#{msgs.exportPdf}" />

			<%-- DMS-Export-Schaltknopf --%>
			<h:commandLink action="#{ProzessverwaltungForm.ExportDMS}" id="action21" title="#{msgs.importDms}"
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && (LoginForm.maximaleBerechtigung == 2 || LoginForm.maximaleBerechtigung == 1) && item.tifDirectoryExists}">
				<h:graphicImage value="/newpages/images/buttons/dms.png" style="margin-right:0px" />
				<x:updateActionListener property="#{ProzessverwaltungForm.myProzess}" value="#{item}" />
			</h:commandLink>

			<%-- PDF-Export-Schaltknopf greyed --%>
			<h:graphicImage
				rendered="#{ProzessverwaltungForm.modusAnzeige!='vorlagen' && (LoginForm.maximaleBerechtigung == 2 || LoginForm.maximaleBerechtigung == 1) && !item.tifDirectoryExists}"
				value="/newpages/images/buttons/dmsGreyed.png" style="margin-right:2px" title="#{msgs.importDms}" />

			<%-- ProzessKopie-Schaltknopf --%>
			<h:commandLink action="#{ProzesskopieForm.Prepare}" id="action22"
				title="#{item.containsUnreachableSteps?msgs.prozessvorlageMitUnvollstaendigenSchrittdetails:msgs.eineKopieDieserProzessvorlageAnlegen}"
				rendered="#{ProzessverwaltungForm.modusAnzeige=='vorlagen'}">
				<h:graphicImage value="/newpages/images/buttons/star_blue.gif" style="margin-right:3px" rendered="#{!item.containsUnreachableSteps}" />
				<h:graphicImage value="/newpages/images/buttons/star_red.gif" style="margin-right:3px" rendered="#{item.containsUnreachableSteps}" />
				<x:updateActionListener property="#{ProzesskopieForm.prozessVorlage}" value="#{item}" />
			</h:commandLink>

			<%-- MassenImport --%>
			<h:commandLink action="#{MassImportForm.Prepare}" id="action222" title="#{msgs.MassenImport}"
				rendered="#{ProzessverwaltungForm.modusAnzeige=='vorlagen' && HelperForm.massImportAllowed}">
				<h:graphicImage value="/newpages/images/buttons/star_blue_multi.png" style="margin-right:3px" rendered="#{!item.containsUnreachableSteps}" />
				<h:graphicImage value="/newpages/images/buttons/star_red.gif" style="margin-right:3px" rendered="#{item.containsUnreachableSteps}" />
				<x:updateActionListener property="#{MassImportForm.template}" value="#{item}" />
			</h:commandLink>

		</h:panelGroup>
	</x:column>

</x:dataTable>

<%-- Neu-Schaltknopf --%>
<h:commandLink action="#{ProzessverwaltungForm.Neu}" immediate="true"
	rendered="#{(LoginForm.maximaleBerechtigung == 1 || LoginForm.maximaleBerechtigung == 2) && ProzessverwaltungForm.modusAnzeige!='vorlagen' && (ProzessverwaltungForm.page.totalResults > LoginForm.myBenutzer.tabellengroesse)}"
	id="new3">
	<h:outputText value="#{msgs.einenNeuenProzessAnlegen}" />
</h:commandLink>

<%-- Neu-Schaltknopf --%>
<h:commandLink action="#{ProzessverwaltungForm.NeuVorlage}" immediate="true"
	rendered="#{(LoginForm.maximaleBerechtigung == 1 || LoginForm.maximaleBerechtigung == 2) && ProzessverwaltungForm.modusAnzeige=='vorlagen' && (ProzessverwaltungForm.page.totalResults > LoginForm.myBenutzer.tabellengroesse)}"
	id="new4">
	<h:outputText value="#{msgs.eineNeueProzessvorlageAnlegen}" />
</h:commandLink>


<htm:table width="100%" border="0">
	<htm:tr valign="top">

		<htm:td align="center">
			<%-- ===================== Datascroller für die Ergebnisse ====================== --%>
			<x:aliasBean alias="#{mypage}" value="#{ProzessverwaltungForm.page}">
				<jsp:include page="/newpages/inc/datascroller.jsp" />
			</x:aliasBean>
			<%-- ===================== // Datascroller für die Ergebnisse ====================== --%>

		</htm:td>
	</htm:tr>
</htm:table>

