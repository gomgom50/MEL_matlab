<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="21008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="SubVIs" Type="Folder"/>
		<Item Name="Coolprop_64bit" Type="Folder">
			<Item Name="CoolProp_advanced" Type="Folder"/>
			<Item Name="CoolProp.dll" Type="Document" URL="../Coolprop_64bit/CoolProp.dll"/>
			<Item Name="Coolprop.lvlps" Type="Document" URL="../Coolprop_64bit/Coolprop.lvlps"/>
			<Item Name="Coolprop_lib.lvlib" Type="Library" URL="../Coolprop_64bit/Coolprop_lib.lvlib"/>
			<Item Name="Untitled 2.vi" Type="VI" URL="../Coolprop_64bit/Untitled 2.vi"/>
		</Item>
		<Item Name="Opgave8Resultat" Type="Folder">
			<Item Name="Resultat.txt" Type="Document" URL="../Opgave8Resultat/Resultat.txt"/>
		</Item>
		<Item Name="Afleverings Tjekliste.docx" Type="Document" URL="../Afleverings Tjekliste.docx"/>
		<Item Name="Beskrivelse.png" Type="Document" URL="../Beskrivelse.png"/>
		<Item Name="NAVN.txt" Type="Document" URL="../NAVN.txt"/>
		<Item Name="opgave 6.txt" Type="Document" URL="../opgave 6.txt"/>
		<Item Name="Opgavebeskrivelser.docx" Type="Document" URL="../Opgavebeskrivelser.docx"/>
		<Item Name="Opgave 1 Arealberegning.vi" Type="VI" URL="../Opgave 1 Arealberegning.vi"/>
		<Item Name="Opgave 2 Tal match.vi" Type="VI" URL="../Opgave 2 Tal match.vi"/>
		<Item Name="Opgave 3 Stoerste tal.vi" Type="VI" URL="../Opgave 3 Stoerste tal.vi"/>
		<Item Name="Opgave 4 Krig.vi" Type="VI" URL="../Opgave 4 Krig.vi"/>
		<Item Name="Opgave 5 Lige Ulige.vi" Type="VI" URL="../Opgave 5 Lige Ulige.vi"/>
		<Item Name="Opgave 6 Array sjov.vi" Type="VI" URL="../Opgave 6 Array sjov.vi"/>
		<Item Name="Opgave 7 Channel wire.vi" Type="VI" URL="../Opgave 7 Channel wire.vi"/>
		<Item Name="Opgave 8 File IO.vi" Type="VI" URL="../Opgave 8 File IO.vi"/>
		<Item Name="Opgave 9 Coolprop.vi" Type="VI" URL="../Opgave 9 Coolprop.vi"/>
		<Item Name="Opgave 10 Dokumentation.vi" Type="VI" URL="../Opgave 10 Dokumentation.vi"/>
		<Item Name="Opgave8Data.txt" Type="Document" URL="../Opgave8Data.txt"/>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="My Zip File" Type="Zip File">
				<Property Name="Absolute[0]" Type="Bool">false</Property>
				<Property Name="BuildName" Type="Str">My Zip File</Property>
				<Property Name="Comments" Type="Str"></Property>
				<Property Name="DestinationID[0]" Type="Str">{A83AD826-2335-4E3D-BBC8-39293D2229A6}</Property>
				<Property Name="DestinationItemCount" Type="Int">1</Property>
				<Property Name="DestinationName[0]" Type="Str">Destination Directory</Property>
				<Property Name="IncludedItemCount" Type="Int">1</Property>
				<Property Name="IncludedItems[0]" Type="Ref">/My Computer</Property>
				<Property Name="IncludeProject" Type="Bool">true</Property>
				<Property Name="Path[0]" Type="Path">../../21E_Test.zip</Property>
				<Property Name="ZipBase" Type="Str">NI_zipbasedefault</Property>
			</Item>
		</Item>
	</Item>
</Project>
