<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="birth.aspx.cs" Inherits="MonitoringDeath.birth" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Рождаемость</title>
    <link rel="shortcut icon" href="img/log.png" />    
    <link href="Styles/bootstrap-responsive.css" rel="Stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ext:ResourceManager ID="ResourceManager1" runat="server"/>
        <%--STORE--%>
        <ext:Store ID="strRegionLife" runat="server">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetRoot">
                    <ActionMethods Read="POST" />
                    <Reader>
                        <ext:XmlReader Record="AddrObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model runat="server">
                    <Fields>
                        <ext:ModelField Name="aoid" Type="String" Mapping="AOID" />
                        <ext:ModelField Name="formalname" Type="String" Mapping="FormalName" />
                        <ext:ModelField Name="shortname" Type="String" Mapping="ShortName" />
                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>
        <ext:Store ID="strAreaLife" runat="server" AutoLoad="false">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetLevel">
                    <ActionMethods Read="POST"/>
                    <Reader>
                        <ext:XmlReader Record="AddrObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model ID="Model2" runat="server">
                    <Fields>
                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>
                <ext:StoreParameter Name="level" Value="3" Mode="Raw" />
                <ext:StoreParameter Name="aoid" Value="#{cmbRegionLife}.getValue()" Mode="Raw" />
                <ext:StoreParameter Name="findname" Value="%" Mode="Value" />
            </Parameters>
        </ext:Store>
        <ext:Store ID="strCityLife" runat="server" AutoLoad="false">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetLevel">
                    <ActionMethods Read="POST"/>
                    <Reader>
                        <ext:XmlReader Record="AddrObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model ID="Model3" runat="server">
                    <Fields>
                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>
                <ext:StoreParameter Name="level" Value="4" Mode="Raw" />
                <ext:StoreParameter Name="aoid" Value="(#{cmbAreaLife}.getValue()!=null)?(#{cmbAreaLife}.getValue()):(#{cmbRegionLife}.getValue())" Mode="Raw" />
                <ext:StoreParameter Name="findname" Value="%" Mode="Value" />
            </Parameters>
        </ext:Store>
        <ext:Store ID="strTownLife" runat="server" AutoLoad="false">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetLevel">
                    <ActionMethods Read="POST"/>
                    <Reader>
                        <ext:XmlReader Record="AddrObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model ID="Model4" runat="server">
                    <Fields>
                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>
                    
                <ext:StoreParameter Name="level" Value="6" Mode="Raw" />
                <ext:StoreParameter Name="aoid" Value="(#{cmbCityLife}.getValue()!=null)?(#{cmbCityLife}.getValue()):(#{cmbAreaLife}.getValue())" Mode="Raw" />
                <ext:StoreParameter Name="findname" Value="%" Mode="Value" />
            </Parameters>
        </ext:Store>

        <ext:Store ID="strAO" runat="server" AutoLoad="false">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetLevel">
                    <ActionMethods Read="POST"/>
                    <Reader>
                        <ext:XmlReader Record="AddrObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model ID="Model27" runat="server">
                    <Fields>
                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>
                    
                <ext:StoreParameter Name="level" Value="6" Mode="Raw" />
                <ext:StoreParameter Name="aoid" Value="(#{cmbCityLife}.getValue()!=null)?(#{cmbCityLife}.getValue()):(#{cmbAreaLife}.getValue())" Mode="Raw" />
                <ext:StoreParameter Name="findname" Value=" АО" Mode="Value" />
            </Parameters>
        </ext:Store>
        <ext:Store ID="strBirthAO" runat="server" AutoLoad="false">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetLevel">
                    <ActionMethods Read="POST"/>
                    <Reader>
                        <ext:XmlReader Record="AddrObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model ID="Model7" runat="server">
                    <Fields>
                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>                    
                <ext:StoreParameter Name="level" Value="6" Mode="Raw" />
                <ext:StoreParameter Name="aoid" Value="(#{cmbCityBirth}.getValue()!=null)?(#{cmbCityBirth}.getValue()):(#{cmbAreaBirth}.getValue())" Mode="Raw" />
                <ext:StoreParameter Name="findname" Value=" АО" Mode="Value" />
            </Parameters>
        </ext:Store>
            
        <ext:Store ID="strStreetLife" runat="server" AutoLoad="false">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetLevel">
                    <ActionMethods Read="POST"/>
                    <Reader>
                        <ext:XmlReader Record="AddrObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model ID="Model5" runat="server">
                    <Fields>
                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>
                
                <ext:StoreParameter Name="level" Value="7" Mode="Raw" />
                <ext:StoreParameter Name="aoid" Value="(#{cmbTownLife}.getValue()!=null)?(#{cmbTownLife}.getValue()):(#{cmbCityLife}.getValue())" Mode="Raw" />
                <ext:StoreParameter Name="findname" Value="%" Mode="Value"/>
            </Parameters>
        </ext:Store>
        <ext:Store ID="strHouseLife" runat="server" AutoLoad="false">
            <Proxy>
                <ext:AjaxProxy Url="test.asmx/GetHouse">
                    <ActionMethods Read="POST"/>
                    <Reader>
                        <ext:XmlReader Record="HouseObj" />
                    </Reader>
                </ext:AjaxProxy>
            </Proxy>
            <Model>
                <ext:Model ID="Model6" runat="server">
                    <Fields>
                        <ext:ModelField Name="houseguid" type="String" Mapping="HouseGUID"/>
                        <ext:ModelField Name="postalcode" type="String" Mapping="PostalCode"/>
                        <ext:ModelField Name="housenum" type="String" Mapping="HouseNum"/>
                        <ext:ModelField Name="buildnum" type="String" Mapping="BuildNum"/>
                        <ext:ModelField Name="strucnum" type="String" Mapping="StrucNum"/>
                        <ext:ModelField Name="fullhouse" type="String" Mapping="FullHouse"/>
                    </Fields>
                </ext:Model>
            </Model>
            <Parameters>
                <ext:StoreParameter Name="aoid" Value="#{cmbStreetLife}.getValue()" Mode="Raw" />
            </Parameters>
        </ext:Store>
        <%--END STORE--%>
        <ext:Panel ID="Panel1" runat="server" Title="Свидетельство о рождении" FormBind="true" OverflowX="Hidden" OverflowY="Hidden" Frame="true" StyleSpec="text-align: left; left: 0px; top: 0px; margin: 0px;" >
            <%--Тул бар--%>
            <TopBar>
                <ext:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <ext:Button ID="Button1" runat="server" Text="Вернуться назад" Icon="ApplicationGo" OnDirectClick="Back_Click" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <FooterBar>
                <ext:Toolbar ID="tbButtons" runat="server">
                    <Items>
                        <ext:Button ID="Previwe" runat="server" Text="Предпросмотр страницы 1" Icon="Eye" Hidden="false">
                            <DirectEvents>
                                <Click OnEvent="btnPrint_1_Click">
                                    <ExtraParams>
                                        <ext:Parameter Name="cmbTown" Value="#{cmbTownLife}.getStore().getRecordsValues()" Mode="Raw" Encode="true" />
                                        <ext:Parameter Name="cmbTown2" Value="#{cmbTownBirth}.getStore().getRecordsValues()" Mode="Raw" Encode="true" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="Previwe2" runat="server" Text="Предпросмотр страницы 2" Icon="Eye" Hidden="false" OnDirectClick="btnPrint_2_Click" />
                        <ext:Button ID="btnSaveExtract" runat="server" Text="Сохранить данные в базу и перейти к печати" Icon="Disk" OnDirectClick="btnSaveExtract_click" />
                        <ext:Button ID="btnPrint_1" runat="server" Text="Печатать страницу 1" Icon="Printer" Disabled="true" OnDirectClick="btnPrint_1_Click">
                            <DirectEvents>
                                <Click OnEvent="btnPrint_1_Click">
                                    <ExtraParams>
                                        <ext:Parameter Name="cmbTown" Value="#{cmbTownLife}.getStore().getRecordsValues()" Mode="Raw" Encode="true" />
                                        <ext:Parameter Name="cmbTown2" Value="#{cmbTownBirth}.getStore().getRecordsValues()" Mode="Raw" Encode="true" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnPrint_2" runat="server" Text="Печатать страницу 2" Icon="Printer" Disabled="true" OnDirectClick="btnPrint_2_Click" />
                        <ext:Button runat="server" Text="Вернуться назад" Icon="ApplicationGo" OnDirectClick="Back_Click" />
                        <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                    </Items>
                </ext:Toolbar>
            </FooterBar>
            <%--Тул бар--%>
            
            <%--Шапка--%>
            <Items>                     
            <ext:Hidden runat="server" ID="id_Kid" Text="null" />
            <ext:Hidden runat="server" ID="id_KidSV" Text="null" />
            <ext:Hidden runat="server" ID="id_Doctor" />
            <ext:Hidden runat="server" ID="FIO_Doctor" />
            <ext:Hidden runat="server" ID="Post_Doctor" />
            <ext:Label ID="Label1" runat="server" Text="** - Обязательные для заполнения поля" StyleSpec="font-size:14px; color:red" />               
                <ext:FieldSet ID="fsAboutSV" runat="server" X="250" Title="Данные о свидетельстве**" Layout="AutoLayout" Width="850" >
                    <Items>    
                        <ext:FieldContainer ID="FieldContainer1" runat="server" Layout="HBoxLayout" AnchorHorizontal="90%"> 
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField ID="SerialSv" runat="server" Flex="1" FieldLabel="Серия" Text="52"  MaxLength="4" Width="200" Disabled="true" /> 
                                <ext:TextField ID="NumberSv" runat="server" Flex="1" FieldLabel="Номер" MaxLength="10" Width="250">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask1" runat="server" Mask="9999999999?" ClearWhenInvalid="false" />
                                    </Plugins>
                                    <DirectEvents>
                                        <Move OnEvent="activF" />
                                    </DirectEvents>
                                </ext:TextField>         
                                <ext:Hidden runat="server" ID="ProvNumber" />
                                <ext:DateField ID="DateSv" runat="server" Flex="1" FieldLabel="Дата выдачи" />   
                            </Items>
                        </ext:FieldContainer>     
                    </Items>
                </ext:FieldSet>
                <%--Конец шапки, начало корешка--%>
                <ext:FieldSet ID="FieldSet1" runat="server" Title="КОРЕШОК" Layout="AutoLayout">
                    <Items>
                    <%--Пункт 1--%>
                        <ext:FieldContainer runat="server" ID="fcBornDead" Layout="HBoxLayout" AnchorHorizontal="95%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:ComboBox runat="server" ID="cmbBirth" Flex="2" FieldLabel="Вид даты рождения:" LabelAlign="Top" LabelWidth="120" OnDirectSelect="cmbBirth_change">
                                    <Items>
                                        <ext:ListItem Text="Известна полная дата" Value="FullDate" />
                                        <ext:ListItem Text="Известен только год" Value="YearDate" />
                                        <ext:ListItem Text="Известен только год и  месяц" Value="YaMDate" />
                                        <ext:ListItem Text="Дата неизвестна" Value="NoDate" />
                                    </Items>
                                </ext:ComboBox>
                                <ext:DateField ID="dfFullDate" runat="server" Flex="1" FieldLabel="Полная дата рождения" LabelAlign="Top" LabelWidth="150" Disabled="true" OnDirectSelect="dfFullDate_select" />
                                <ext:NumberField ID="nbfYearDate" runat="server" Flex="1" FieldLabel="Год:" LabelAlign="Top" MaxLength="4" MinValue="1899" Text="2000" MaxValue="2222" Disabled="true" OnDirectChange="nbfYearDate_changed" />
                                <ext:ComboBox runat="server" ID="cmbMonthDate" Flex="1" Text="XX" FieldLabel="Месяц:" LabelAlign="Top" Disabled="true" OnDirectSelect="cmbMonthDate_select">
                                    <Items>
                                        <ext:ListItem Text="Январь" Value="01" />
                                        <ext:ListItem Text="Февраль" Value="02" />
                                        <ext:ListItem Text="Март" Value="03" />
                                        <ext:ListItem Text="Апрель" Value="04" />
                                        <ext:ListItem Text="Май" Value="05" />
                                        <ext:ListItem Text="Июнь" Value="06" />
                                        <ext:ListItem Text="Июль" Value="07" />
                                        <ext:ListItem Text="Август" Value="08" />
                                        <ext:ListItem Text="Сентярь" Value="09" />
                                        <ext:ListItem Text="Октябрь" Value="10" />
                                        <ext:ListItem Text="Ноябрь" Value="11" />
                                        <ext:ListItem Text="Декабрь" Value="12" />
                                    </Items>
                                </ext:ComboBox>
                                <ext:TextField runat="server" ID="txfFullDate" Flex="2" Disabled="true" FieldLabel="1. Ребёнок родился:" LabelAlign="Top" AllowBlank="false"/>                                           
                                            
                                <ext:TextField ID="TimeBirth" Flex="1" runat="server" FieldLabel="время" LabelWidth="50" LabelAlign="Top">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask2" runat="server" Mask="99:99" ClearWhenInvalid="true" />
                                    </Plugins>
                                </ext:TextField>
                                <ext:Button ID="Button2" runat="server" Width="30" Icon="Delete" ToolTip="Очистить поля" ToolTipType="Title">
                                    <Listeners>
                                        <Click Handler="#{BirthDay}.clear();#{TimeBirth}.clear();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:FieldContainer>
                    <%--Пункт 2--%>                        
                        <ext:FieldContainer runat="server" ID="fcMotherFIO" Layout="HBoxLayout" AnchorHorizontal="70%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" ID="txfMotherFamily" Flex="1" FieldLabel="2. Фамилия матери" LabelWidth="160">
                                    <Listeners>
                                        <Change Handler="#{txfRecipientFamily}.setValue(this.getValue())" />
                                    </Listeners>
                                </ext:TextField>
                                <ext:TextField runat="server" ID="txfMotherName" Flex="1" FieldLabel="Имя матери" LabelWidth="80">
                                    <Listeners>
                                        <Change Handler="#{txfRecipientName}.setValue(this.getValue())" />
                                    </Listeners>
                                </ext:TextField>
                                <ext:TextField runat="server" ID="txfMotherFatherName" Flex="1" FieldLabel="Отчество матери" LabelWidth="100">
                                    <Listeners>
                                        <Change Handler="#{txfRecipientFatherName}.setValue(this.getValue())" />
                                    </Listeners>
                                </ext:TextField>
                                <ext:Button ID="Button5" runat="server" Width="30" Icon="Delete" ToolTip="Очистить поля" ToolTipType="Title">
                                    <Listeners>
                                        <Click Handler="#{txfMotherFamily}.clear();#{txfMotherName}.clear();#{txfMotherFatherName}.clear();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:FieldContainer>
                    <%--Пункт 3--%>
                        <ext:FieldContainer runat="server" ID="fcMotherBirthDay" Layout="HBoxLayout" AnchorHorizontal="26%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:DateField runat="server" ID="MotherBirthDay" Flex="1" LabelWidth="160" FieldLabel="3. Дата рождения матери" />
                                <ext:Button ID="Button6" runat="server" Width="30" Icon="Delete" ToolTip="Очистить поля" ToolTipType="Title">
                                    <Listeners>
                                        <Click Handler="#{MotherBirthDay}.clear();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:FieldContainer>
                        <%--Пункт 4--%>
                      

                    <%--Пункт 7--%>
                        <ext:Label ID="Label2" runat="server" Text="4. Место постоянного жительства (регистрации) матери ребёнка:" Margin="5" />
                        <ext:Checkbox runat="server" ID="ifAlien" LabelWidth="230" FieldLabel="Если гражданин(ка) другой страны" >
                            <DirectEvents>
                                <Change OnEvent="ifAlien_check" />
                            </DirectEvents>
                        </ext:Checkbox>
                        <ext:FieldContainer runat="server" ID="AlienGroup" Layout="HBoxLayout" AnchorHorizontal="100%" Hidden="true">
                            <Defaults>
                                <ext:Parameter Name="margins" Value="0 2 0 2" Mode="Value"/>
                            </Defaults>
                            <Items>                                            
                                <ext:TextField runat="server" FieldLabel="Субъект Российской Федерации" LabelAlign="Top" ID="txfRegionAlien"  />
                                <ext:TextField runat="server" FieldLabel="Район" LabelAlign="Top" ID="txfAreaAlien"  />
                                <ext:TextField runat="server" FieldLabel="Город" LabelAlign="Top" ID="txfCityAlien"  />
                                <ext:TextField runat="server" FieldLabel="Населённый пункт" LabelAlign="Top" ID="txfTownAlien"  />
                                <ext:TextField runat="server" FieldLabel="Улица" LabelAlign="Top" ID="txfStreetAlien"  />
                                <ext:TextField runat="server" FieldLabel="Дом" LabelAlign="Top" ID="txfHouseAlien"  />
                                <ext:TextField runat="server" ID="txfRoomAlien" FieldLabel="Квартира" MaxLength="6" LabelAlign="Top" />
                                <ext:Button ID="Button12" runat="server" Width="30" Icon="Delete" ToolTip="Очистить поля" ToolTipType="Title">
                                    <Listeners>
                                        <Click Handler="#{txfRegionAlien}.clear();#{txfAreaAlien}.clear();#{txfCityAlien}.clear();#{txfTownAlien}.clear();#{txfStreetAlien}.clear();#{txfHouseAlien}.clear();#{txfRoomAlien}.clear();" />
                                    </Listeners>
                                </ext:Button>                                            
                            </Items>
                        </ext:FieldContainer>
                        <ext:FieldContainer runat="server" ID="fcMotherLifePlace" Layout="HBoxLayout" AnchorHorizontal="95%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:ComboBox runat="server" ID="cmbRegionLife" StoreID="strRegionLife" Flex="3" FieldLabel="Республика, край, область" LabelWidth="160" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">                                                                   
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl1" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbAreaLife}.clearValue();#{strAreaLife}.load();#{cmbCityLife}.clearValue();#{strCityLife}.load();#{aoidLife}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>  
                                <ext:ComboBox runat="server" ID="cmbAreaLife" StoreID="strAreaLife" Flex="3" FieldLabel="Район" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl2" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbCityLife}.clearValue();#{strCityLife}.load();#{cmbTownLife}.clearValue();#{strTownLife}.load();#{aoidLife}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cmbCityLife" StoreID="strCityLife" Flex="3" FieldLabel="Город" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl3" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbTownLife}.clearValue();#{strTownLife}.load();#{strAO}.load();#{cmbStreetLife}.clearValue();#{strStreetLife}.load();#{aoidLife}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cmbTownLife" StoreID="strTownLife" Flex="3" FieldLabel="Село" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl4" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname}</div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbStreetLife}.clearValue();#{strStreetLife}.load();#{aoidLife}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cmbAO" StoreID="strAO" Flex="3" FieldLabel="Административный округ" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl17" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname}</div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{aoidAO}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cmbStreetLife" Hidden="true" StoreID="strStreetLife" Flex="3" FieldLabel="Улица" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl5" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbHouseLife}.clearValue();#{strHouseLife}.load();  #{aoidLife}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cmbHouseLife" Hidden="true" StoreID="strHouseLife" Flex="1" FieldLabel="Дом" LabelWidth="50" LabelAlign="Top" DisplayField="fullhouse" ValueField="houseguid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl6" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{postalcode}, {fullhouse}</div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{aoidLife}.setValue(this.getValue());#{aoidHouseLife}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:TextField runat="server" ID="txfStreetLife" Flex="3" FieldLabel="Улица" LabelAlign="Top" />
                                <ext:TextField runat="server" ID="txfHouseLife" Flex="1" FieldLabel="Дом" LabelAlign="Top" />
                                <ext:TextField runat="server" ID="nbfRoomLife" Flex="2" FieldLabel="Квартира" LabelWidth="50" LabelAlign="Top">
                                    <%--<Plugins>
                                        <ext:InputMask ID="InputMask3" runat="server" Mask="9?99" ClearWhenInvalid="false" />
                                    </Plugins>--%>
                                </ext:TextField>
                                <ext:Hidden runat="server" ID="aoidLife" />
                                <ext:Hidden runat="server" ID="aoidAO" />
                                <ext:Hidden runat="server" ID="aoidHouseLife" />
                                <ext:Button ID="Button7" runat="server" Width="30" Icon="Delete" ToolTip="Очистить поля" ToolTipType="Title">
                                    <Listeners>
                                        <Click Handler="#{cmbRegionLife}.clear();#{cmbAreaLife}.clear();#{cmbCityLife}.clear();
                                        #{cmbTownLife}.clear();#{cmbAO}.clear();#{txfStreetLife}.clear();
                                        #{txfHouseLife}.clear();#{nbfRoomLife}.clear();#{aoidLife}.clear();#{aoidHouseLife}.clear();#{aoidAO}.clear();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:FieldContainer>
                    <%--Пункт 5--%>
                        <ext:RadioGroup ID="RadioGroup3" runat="server" FieldLabel="5. Местность" LabelWidth="80" AnchorHorizontal="30%" Margin="5">
                            <Items>
                                <ext:Radio runat="server" ID="LocationLife_1" BoxLabel="городская" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio runat="server" ID="LocationLife_2" BoxLabel="сельская" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio ID="LocationLife_3" runat="server" BoxLabelAlign="Before" BoxLabel="Неизвестно" LabelWidth="100" />
                            </Items>
                        </ext:RadioGroup>
                    <%--Пункт 6--%>                        
                        <ext:RadioGroup ID="RadioGroup4" runat="server" FieldLabel="6. Пол" LabelWidth="80" AnchorHorizontal="20%" Margin="5">
                            <Items>
                                <ext:Radio runat="server" ID="SexMale" BoxLabel="мальчик" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio runat="server" ID="SexFemale" BoxLabel="девочка" BoxLabelAlign="Before" LabelWidth="100" />
                            </Items>
                        </ext:RadioGroup>
                    <%--Пункт 7--%>
                        <ext:RadioGroup ID="RadioGroup1" runat="server" FieldLabel="7. Роды произошли" LabelWidth="150" AnchorHorizontal="45%" Margin="5">
                            <Items>
                                <ext:Radio runat="server" ID="BirthOccurred_1" Checked="true" BoxLabel="в стационаре" BoxLabelAlign="Before" LabelWidth="100" OnDirectCheck="BirthOccurred_1_Check" />
                                <ext:Radio runat="server" ID="BirthOccurred_2" BoxLabel="дома" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio runat="server" ID="BirthOccurred_3" BoxLabel="в другом месте" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio runat="server" ID="BirthOccurred_4" BoxLabel="неизвестно" BoxLabelAlign="Before" LabelWidth="100" />
                            </Items>
                        </ext:RadioGroup>                        
                        <ext:ComboBox runat="server" ID="BirthOccurred_LPU" FieldLabel="ЛПУ:" DisplayField="NameBirthOccurredLpu" ValueField="id_BirthOccorredLpu" AnchorHorizontal="40%" Margin="5">
                            <Store>
                                <ext:Store runat="server" ID="strBirthOccurred_LPU">
                                    <Model>
                                        <ext:Model ID="Model1" runat="server">
                                            <Fields>                                                                    
                                                <ext:ModelField Name="NameBirthOccurredLpu" Mapping="NameBirthOccurredLpu" />
                                                <ext:ModelField Name="id_BirthOccorredLpu" Mapping="id_BirthOccorredLpu" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                        </ext:ComboBox>
                    <%--Пункт 8--%>                        
                        <ext:FieldContainer runat="server" ID="fcRecipient" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>                                
                                <ext:TextField runat="server" ID="txfRecipientFamily" Flex="1" FieldLabel="Фамилия получателя" LabelAlign="Top" />
                                <ext:TextField runat="server" ID="txfRecipientName" Flex="1" FieldLabel="Имя получателя" LabelAlign="Top" />
                                <ext:TextField runat="server" ID="txfRecipientFatherName" Flex="1" FieldLabel="Отчество получателя" LabelAlign="Top" />
                                <ext:TextField runat="server" ID="txfRecipientRatio" Flex="1" FieldLabel="Отношение к ребёнку" LabelAlign="Top"/>
                            </Items>
                        </ext:FieldContainer>
                        <ext:FieldContainer runat="server" ID="fcRecipientDoc" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>                                
                                <ext:TextField runat="server" ID="txfRecipientDocSerial" Flex="1" FieldLabel="Серия документа" LabelAlign="Top">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask5" runat="server" Mask="9999?" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                                <ext:TextField runat="server" ID="txfRecipientDocNumber" Flex="1" FieldLabel="Номер документа" LabelAlign="Top">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask6" runat="server" Mask="999999?" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                                <ext:TextField runat="server" ID="txfRecipientDocWho" Flex="3" FieldLabel="Кто выдал документ" LabelAlign="Top" />
                                <ext:DateField runat="server" ID="DateGotSv" Flex="1" Hidden="true" FieldLabel="Дата получения свидетельства" LabelAlign="Top"/>
                            </Items>
                        </ext:FieldContainer>
                         <ext:FieldContainer runat="server" ID="FieldContainer4" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" ID="txfRecipientDocPol" Flex="3" FieldLabel="Документ удостоверяющий полномочия получателя" LabelAlign="Top" />
                            </Items>
                        </ext:FieldContainer>
                    </Items>
                </ext:FieldSet>
                <%--Конец корешка, начало свидетельства--%>
                <ext:Label ID="Label4" runat="server" Text="В медицинском свидетельстве присутствуют поля, которые уже были заполнены в корешке, и они в следующем блоке не отображаются" StyleSpec="font-size:14px; color:red" />               
                <ext:FieldSet ID="FieldSet2" runat="server" Title="МЕДИЦИНСКОЕ СВИДЕТЕЛЬСТВО" Layout="AutoLayout">
                    <Items>
                        <ext:Label ID="Label5" runat="server" Text="Мать:"/>
                        
                    <%--Пункт 6--%>
                        <ext:RadioGroup ID="MaritalStatus" runat="server" FieldLabel="6. Семейное положение" LabelWidth="160" AnchorHorizontal="75%" Margin="5">
                            <Items>
                                <ext:Radio runat="server" ID="MaritalStatus_1" BoxLabel="состоит в зарегистрированном браке" BoxLabelAlign="Before" LabelWidth="300" />
                                <ext:Radio runat="server" ID="MaritalStatus_2" BoxLabel="не состоит в зарегистрированном браке" BoxLabelAlign="Before" LabelWidth="300" />
                                <ext:Radio runat="server" ID="MaritalStatus_3" BoxLabel="неизвестно" BoxLabelAlign="Before" LabelWidth="100" />
                            </Items>
                        </ext:RadioGroup>
                    <%--Пункт 7--%>
                        <ext:RadioGroup runat="server" ID="Education" FieldLabel="7. Образование" LabelWidth="160" AnchorHorizontal="80%" Margin="5" >
                            <Items>
                                <ext:Radio runat="server" ID="rEducation_1" BoxLabel="профессиональное" BoxLabelAlign="Before" LabelWidth="120" OnDirectCheck="Education_Check"/>
                                <ext:ComboBox runat="server" ID="cmbEducation_1" LabelAlign="Left">
                                    <Items>
                                        <ext:ListItem Text="высшее" Value="1" />
                                        <ext:ListItem Text="неполное высшее" Value="2" />
                                        <ext:ListItem Text="среднее профессиональное" Value="3" />
                                     </Items>
                                </ext:ComboBox>
                                <ext:Radio runat="server" ID="rEducation_2" BoxLabel="общее" BoxLabelAlign="Before" LabelWidth="50" OnDirectCheck="Education_Check" />
                                <ext:ComboBox runat="server" ID="cmbEducation_2" Disabled="true">
                                    <Items>
                                        <ext:ListItem Text="среднее" Value="4" />
                                        <ext:ListItem Text="основное" Value="5" />
                                        <ext:ListItem Text="начальное" Value="6" />
                                        <ext:ListItem Text="не имеет начального образования" Value="7" />
                                    </Items>
                                </ext:ComboBox>
                                <ext:Radio runat="server" ID="rEducation_3" BoxLabel="неизвестно" BoxLabelAlign="Before" LabelWidth="100" OnDirectCheck="Education_Check" />
                            </Items>
                        </ext:RadioGroup>
                    <%--Пункт 8--%>
                        <ext:RadioGroup runat="server" ID="Work" FieldLabel="8. Занятость" LabelWidth="160" AnchorHorizontal="90%" Margin="5">
                            <Items>
                                <ext:Radio runat="server" ID="rWork_1" BoxLabel="был(а) занат(а) в экономике" BoxLabelAlign="Before" LabelWidth="180" OnDirectCheck="Work_Check" />
                                <ext:ComboBox runat="server" ID="cmbWork_1">
                                    <Items>
                                        <ext:ListItem Text="Работала" Value="1" />
                                        <ext:ListItem Text="Проходила военную или приравненную к ней службу" Value="2" />
                                     </Items>
                                </ext:ComboBox>
                                <ext:Radio runat="server" ID="rWork_2" BoxLabel="не был(а) занят(а) в экономике" BoxLabelAlign="Before" LabelWidth="200" OnDirectCheck="Work_Check" />
                                <ext:ComboBox runat="server" ID="cmbWork_2" Disabled="true" >
                                    <Items>
                                        <ext:ListItem Text="студентка" Value="3" />
                                        <ext:ListItem Text="не работала" Value="4" />
                                    </Items>
                                </ext:ComboBox>
                                <ext:Radio runat="server" ID="rWork_3" BoxLabel="прочие" BoxLabelAlign="Before" LabelWidth="100" OnDirectCheck="Work_Check" />
                            </Items>
                        </ext:RadioGroup>
                    <%--Пункт 9--%>   
                        <ext:FieldContainer runat="server" ID="FieldContainer7" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults> 
                            <Items>
                                <ext:TextField runat="server" ID="nbfGoWeek" FieldLabel="9. Срок первой явки к врачу (фельдшеру, акушерке)(в неделях)" LabelWidth="400" AnchorHorizontal="30%">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask7" runat="server" Mask="9?9" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                            </Items>
                        </ext:FieldContainer>
                         <ext:FieldContainer runat="server" ID="FieldContainer8" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults> 
                            <Items>
                                <ext:TextField runat="server" ID="nbfNumberChield" FieldLabel="10. Которым по счёту ребёнок был рождён у матери" LabelWidth="400" AnchorHorizontal="30%">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask4" runat="server" Mask="9?9" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                            </Items>
                        </ext:FieldContainer>
                        <%--Пункт 10--%>
                        <ext:FieldContainer runat="server" ID="FieldContainer9" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults> 
                            <Items>
                                <ext:TextField runat="server" ID="SnilsTxt" FieldLabel="11. Снилс" LabelWidth="400" AnchorHorizontal="30%">
                              <Plugins>
                                        <ext:InputMask ID="InputMask11" runat="server" Mask="999-999-999 99" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                            </Items>
                        </ext:FieldContainer>
                        <%--Пункт 11--%>
                        <ext:FieldContainer runat="server" ID="FieldContainer10" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults> 
                            <Items>
                                <ext:TextField runat="server" ID="PolisTxt" FieldLabel="12. Полис ОМС" LabelWidth="400" AnchorHorizontal="30%">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask" runat="server" Mask="9999999999999999" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                            </Items>
                        </ext:FieldContainer>


                        <ext:FieldContainer runat="server" ID="FieldContainer12" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults> 
                            <Items>
                                <ext:TextField runat="server" ID="TypeDocument" FieldLabel="13. Документ, удостоверяющий личность: " LabelWidth="400" AnchorHorizontal="30%">
                                   
                                </ext:TextField>
                            </Items>
                        </ext:FieldContainer>

                          <ext:FieldContainer runat="server" ID="FieldContainer11" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>                                
                                <ext:TextField runat="server" ID="SerialDocum" Flex="1" FieldLabel="Серия документа" LabelAlign="Top">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask3" runat="server" Mask="9999?" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                                <ext:TextField runat="server" ID="NumberDocum" Flex="1" FieldLabel="Номер документа" LabelAlign="Top">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask8" runat="server" Mask="999999?" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                                <ext:TextField runat="server" ID="DocWho" Flex="3" FieldLabel="Кем и когда выдан документ" LabelAlign="Top" />
                                </Items>
                               </ext:FieldContainer>


                        <ext:Label ID="Label6" runat="server" Text="Ребёнок:" />                        
                    <%--Пункт 11--%>
                        <ext:FieldContainer runat="server" ID="FieldContainer5" Layout="HBoxLayout" AnchorHorizontal="30%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" ID="txfKidFamily" Flex="1" FieldLabel="11. Фамилия ребёнка" LabelWidth="160" />                                
                                <ext:Button ID="Button3" runat="server" Width="30" Icon="Delete" ToolTip="Очистить поля" ToolTipType="Title">
                                    <Listeners>
                                        <Click Handler="#{txfKidFamily}.clear();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:FieldContainer>
                    <%--Пункт 12--%>
                        <ext:FieldContainer ID="FieldContainer2" runat="server">
                            <Items>
                                <ext:Label ID="Label7" runat="server" Text="12. Место рождения:" Margin="5" />
                            </Items>
                        </ext:FieldContainer>
                        <ext:FieldContainer runat="server" ID="fcPlaceBirth" Layout="HBoxLayout" AnchorHorizontal="95%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:ComboBox runat="server" ID="cmbRegionBirth" Flex="3" FieldLabel="Республика, край, область" LabelWidth="160" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true"  MinChars="1" QueryMode="Local">                                                                   
                                    <Store>
                                        <ext:Store ID="strRegionBirth" runat="server">
                                            <Proxy>
                                                <ext:AjaxProxy Url="test.asmx/GetRoot">
                                                    <ActionMethods Read="POST" />
                                                    <Reader>
                                                        <ext:XmlReader Record="AddrObj" />
                                                    </Reader>
                                                </ext:AjaxProxy>
                                            </Proxy>
                                            <Model>
                                                <ext:Model ID="Model16" runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="aoid" Type="String" Mapping="AOID" />
                                                        <ext:ModelField Name="formalname" Type="String" Mapping="FormalName" />
                                                        <ext:ModelField Name="shortname" Type="String" Mapping="ShortName" />
                                                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>                                                    
                                    </Store>
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl13" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbAreaBirth}.clearValue();#{strAreaBirth}.load();#{cmbCityBirth}.clearValue();#{strCityBirth}.load();#{AoidBirth}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>  
                                <ext:ComboBox runat="server" ID="cmbAreaBirth" Flex="3" FieldLabel="Район" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <Store>
                                        <ext:Store ID="strAreaBirth" runat="server" AutoLoad="false">
                                            <Proxy>
                                                <ext:AjaxProxy Url="test.asmx/GetLevel">
                                                    <ActionMethods Read="POST"/>
                                                    <Reader>
                                                        <ext:XmlReader Record="AddrObj" />
                                                    </Reader>
                                                </ext:AjaxProxy>
                                            </Proxy>
                                            <Model>
                                                <ext:Model ID="Model17" runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                                                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                                                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                                                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                            <Parameters>
                                                <ext:StoreParameter Name="findname" Value="%" Mode="Value" />
                                                <ext:StoreParameter Name="level" Value="3" Mode="Raw" />
                                                <ext:StoreParameter Name="aoid" Value="#{cmbRegionBirth}.getValue()" Mode="Raw" />
                                            </Parameters>
                                        </ext:Store>
                                    </Store>
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl14" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbCityBirth}.clearValue();#{strCityBirth}.load();#{cmbTownBirth}.clearValue();#{strTownBirth}.load();#{AoidBirth}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cmbCityBirth" Flex="3" FieldLabel="Город" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <Store>
                                        <ext:Store ID="strCityBirth" runat="server" AutoLoad="false">
                                            <Proxy>
                                                <ext:AjaxProxy Url="test.asmx/GetLevel">
                                                    <ActionMethods Read="POST"/>
                                                    <Reader>
                                                        <ext:XmlReader Record="AddrObj" />
                                                    </Reader>
                                                </ext:AjaxProxy>
                                            </Proxy>
                                            <Model>
                                                <ext:Model ID="Model18" runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                                                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                                                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                                                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                            <Parameters>
                                                <ext:StoreParameter Name="findname" Value="%" Mode="Value" />
                                                <ext:StoreParameter Name="level" Value="4" Mode="Raw" />
                                                <ext:StoreParameter Name="aoid" Value="(#{cmbAreaBirth}.getValue()!=null)?(#{cmbAreaBirth}.getValue()):(#{cmbRegionBirth}.getValue())" Mode="Raw" />
                                            </Parameters>
                                        </ext:Store>
                                    </Store>
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl15" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{cmbTownBirth}.clearValue();#{strTownBirth}.load();#{AoidBirth}.setValue(this.getValue());#{strBirthAO}.load();" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cmbTownBirth" Flex="3" FieldLabel="Село" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <Store>
                                        <ext:Store ID="strTownBirth" runat="server" AutoLoad="false">
                                            <Proxy>
                                                <ext:AjaxProxy Url="test.asmx/GetLevel">
                                                    <ActionMethods Read="POST"/>
                                                    <Reader>
                                                        <ext:XmlReader Record="AddrObj" />
                                                    </Reader>
                                                </ext:AjaxProxy>
                                            </Proxy>
                                            <Model>
                                                <ext:Model ID="Model19" runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="aoid" type="String" Mapping="AOID"/>
                                                        <ext:ModelField Name="formalname" type="String" Mapping="FormalName"/>
                                                        <ext:ModelField Name="shortname" type="String" Mapping="ShortName"/>
                                                        <ext:ModelField Name="CurrStatus" Type="String" Mapping="CurrStatus" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                            <Parameters>
                                                <ext:StoreParameter Name="findname" Value="%" Mode="Value" />
                                                <ext:StoreParameter Name="level" Value="6" Mode="Raw" />
                                                <ext:StoreParameter Name="aoid" Value="(#{cmbCityBirth}.getValue()!=null)?(#{cmbCityBirth}.getValue()):(#{cmbAreaBirth}.getValue())" Mode="Raw" />
                                            </Parameters>
                                        </ext:Store>
                                    </Store>
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl16" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname} </div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{AoidBirth}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>                                
                                <ext:ComboBox runat="server" ID="cmbBirthAO" StoreID="strBirthAO" Flex="3" FieldLabel="Административный округ" LabelWidth="50" LabelAlign="Top" DisplayField="formalname" ValueField="aoid" TypeAhead="true" ForceSelection="true" MinChars="1" QueryMode="Local">
                                    <ListConfig ItemSelector=".row">
                                        <Tpl ID="Tpl7" runat="server">
                                            <Html>
                                                <tpl for=".">
                                                    <div class="row">{shortname} {formalname}</div>
                                                </tpl>
                                            </Html>
                                        </Tpl>
                                    </ListConfig>
                                    <Listeners>
                                        <Select Handler="#{aoidAOBirth}.setValue(this.getValue());" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:Hidden runat="server" ID="aoidAOBirth" />
                                <ext:Hidden runat="server" ID="AoidBirth" />
                                <ext:Button ID="Button4" runat="server" Width="30" Icon="Delete" ToolTip="Очистить поля" ToolTipType="Title">
                                    <Listeners>
                                        <Click Handler="#{cmbRegionBirth}.clear();#{cmbAreaBirth}.clear();#{cmbCityBirth}.clear();
                                        #{cmbTownBirth}.clear();#{AoidBirth}.clear();#{aoidAOBirth}.clear();#{cmbBirthAO}.clear();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:FieldContainer>
                    <%--Пункт 13--%>
                        <ext:RadioGroup ID="RadioGroup6" runat="server" FieldLabel="13. Местность" LabelWidth="160" AnchorHorizontal="40%" Margin="5">
                            <Items>
                                <ext:Radio runat="server" ID="LocationBirth_1" BoxLabel="городская" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio runat="server" ID="LocationBirth_2" BoxLabel="сельская" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio ID="LocationBirth_3" runat="server" BoxLabelAlign="Before" BoxLabel="Неизвестно" LabelWidth="100" />
                            </Items>
                        </ext:RadioGroup>                    
                    <%--Пункт 16--%>
                        <ext:FieldContainer ID="fcWeight" runat="server">
                            <Items>
                                <ext:NumberField runat="server" ID="nbfWeightKid" FieldLabel="16. Масса тела ребёнка при рождении (грамм)" LabelWidth="300" MinValue="1" MaxValue="9999" AnchorHorizontal="30%" Margin="5" />
                            </Items>
                        </ext:FieldContainer>
                    <%--Пункт 17--%>
                        <ext:FieldContainer ID="fcLength" runat="server">
                            <Items>
                                <ext:NumberField runat="server" ID="nbfLengthKid" FieldLabel="17. Длина тела ребёнка при рождении (см.)" LabelWidth="300" MinValue="1" MaxValue="99" AnchorHorizontal="30%" Margin="5" />
                            </Items>
                        </ext:FieldContainer>
                    <%--Пункт 18--%>
                    <ext:Label ID="Label8" runat="server" Text="18. Ребёнок родился:" Margin="5" />
                        <ext:FieldContainer ID="FieldContainer3" runat="server" Layout="HBoxLayout" AnchorHorizontal="30%">
                            <Items>
                                <ext:Checkbox runat="server" ID="chbStillBirth_1" Flex="1" FieldLabel="при одноплодных родах" LabelWidth="150" Margin="5" Checked="true" OnDirectCheck="VidBirth_Check"/>
                            </Items>
                        </ext:FieldContainer>
                        <ext:FieldContainer ID="FieldContainer6" runat="server" Layout="HBoxLayout" AnchorHorizontal="50%">
                            <Items>
                                <ext:TextField runat="server" ID="nbfStillBirth_2" Flex="2" FieldLabel="при многоплодных родах: которым по счёту" LabelWidth="250" Margin="5" Disabled="true">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask9" runat="server" Mask="9?9" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                                <ext:TextField runat="server" ID="nbfStillBirth_3" Flex="1" FieldLabel="число родившихся " LabelWidth="150" Margin="5" Disabled="true">
                                    <Plugins>
                                        <ext:InputMask ID="InputMask10" runat="server" Mask="9?9" ClearWhenInvalid="false" />
                                    </Plugins>
                                </ext:TextField>
                            </Items>
                        </ext:FieldContainer>                   
                    <%--Пункт 19--%>
                        <ext:RadioGroup ID="rFaceTakeBirth" runat="server" FieldLabel="19. Лицо, принимавшее роды" LabelWidth="180" AnchorHorizontal="50%" Margin="5">
                            <Items>
                                <ext:Radio runat="server" ID="FaceTakeBirth_1" BoxLabel="врач-акушер-гинеколог" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio runat="server" ID="FaceTakeBirth_2" BoxLabel="фельдшер, акушерка" BoxLabelAlign="Before" LabelWidth="100" />
                                <ext:Radio runat="server" ID="FaceTakeBirth_3" BoxLabel="другое" BoxLabelAlign="Before" LabelWidth="100" />
                            </Items>
                        </ext:RadioGroup>                             
                        <ext:FieldContainer ID="fcHead" runat="server" Layout="HBoxLayout" AnchorHorizontal="80%">
                            <Defaults>
                                <ext:Parameter Name="padding" Value="5 5 0 5" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" Flex="1" ID="txfHead_1" FieldLabel="Руководитель медицинской организации: Фамилия " LabelAlign="Top" />
                                <ext:TextField runat="server" Flex="1" ID="txfHead_2" FieldLabel="Имя" LabelAlign="Top" />
                                <ext:TextField runat="server" Flex="1" ID="txfHead_3" FieldLabel="Отчество" LabelAlign="Top" />
                            </Items>
                        </ext:FieldContainer>
                    </Items>
                </ext:FieldSet>
            </Items>
        </ext:Panel>
    </div>
    </form>
</body>
</html>
