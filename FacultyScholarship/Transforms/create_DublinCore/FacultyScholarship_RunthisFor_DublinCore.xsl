<?xml version="1.0" encoding="UTF-8"?>
 <!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2014-07-18
UPDATED ON: 2014-12-18
This stylesheet converts the Art History Department Excel files to qualified Dublin Core based on the mappings found in the MIRA data dictionary.
-->

<!-- If title case proves necesssary put this between the dc:title elements <xsl:value-of select="alex:fnTitleCase(normalize-space(replace(title,'\.$','')))"/> and declare alex.edu in the namespace-->

<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <!--This calls the named templates found in the following xslt(s) for parsing specific fields into approprite data for ingest  -->
    <xsl:import href="../../../Helpers/SplitField_helper.xslt"/>
    <xsl:import href="../../../Helpers/Filename_helper.xslt"/>
    <!--This changes the output to xml -->
    <xsl:output method="xml" indent="yes" use-character-maps="killSmartPunctuation" encoding="UTF-8"/>
    <xsl:character-map name="killSmartPunctuation">
        <xsl:output-character character="“" string="&quot;"/>
        <xsl:output-character character="”" string="&quot;"/>
        <xsl:output-character character="’" string="'"/>
        <xsl:output-character character="‘" string="'"/>
        <xsl:output-character character="&#x2013;" string="-"/>
    </xsl:character-map>
    <!-- this starts the crosswalk-->
    <xsl:template match="/">        
        <input xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
            xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/"
            xmlns:dcterms="http://purl.org/dc/terms/"
            xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/"
            xmlns:ac="http://purl.org/dc/dcmitype/"
            xmlns:rel="info:fedora/fedora-system:def/relations-external#">
            <!-- IF I NEED TO DO A BATCH XSLT: this uses the collection function which looks for a document called collection.xml, which in turn references all the seperate xml files I want meged and transformed into one large xml file for ingest. Insert the following instead of <xsl:for-each select="root/row"> 
            <xsl:for-each select="collection('collection.xml')/root/row">
            -->
            <xsl:for-each select="collection('xml/collection.xml')/root/row">
                <digitalObject>
                    <!-- this portion produces a unique filename by calling the template xslt named filename -->
                    <file>
                        <xsl:call-template name="filename">
                            <xsl:with-param name="file"/>
                        </xsl:call-template>
                    </file>
                    <!-- this portion crosswalks the rel:hasModel depending on the following format -->
                    <xsl:choose>
                        <xsl:when test="format='application/mp3'">
                            <rel:hasModel>info:fedora/cm:Audio</rel:hasModel>
                        </xsl:when>
                        <xsl:when test="format='application/mp4'">
                            <rel:hasModel>info:fedora/afmodel:TuftsVideo</rel:hasModel>
                        </xsl:when>
                        <xsl:when test="format='image/tiff'">
                            <rel:hasModel>info:fedora/cm:Image.4DS</rel:hasModel>
                        </xsl:when>
                        <xsl:otherwise>
                            <rel:hasModel>info:fedora/cm:Text.PDF</rel:hasModel>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- this portion crosswalks the Excel element title to the dc:title element -->
                    <dc:title>
                        <xsl:value-of select="normalize-space(replace(replace(Title,'\.$',''),'; ',';'))"
                        />.</dc:title>
                    <!-- this portion crosswalks the Excel element Alternative_Title to the dcterms:alternative element -->   
                    <xsl:call-template name="altTitleSplit">
                        <xsl:with-param name="altTitleText">
                            <dcterms:alternative>
                                <xsl:value-of select="normalize-space(replace(replace(Alternative_Title,'\.$',''),'; ',';'))"/>
                            </dcterms:alternative>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element creators to the dc:creator element -->
                    <xsl:call-template name="CreatorSplit">
                        <xsl:with-param name="creatorText">
                            <xsl:value-of select="normalize-space(Creator)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element contributors to the dc:contributor element -->
                    <xsl:call-template name="ContributorSplit">
                        <xsl:with-param name="contributorText">
                            <xsl:value-of select="normalize-space(Contributors)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element description to the dc:description element -->
                    <xsl:call-template name="DescriptionSplit">
                        <xsl:with-param name="descriptionText">
                            <xsl:value-of
                                select="normalize-space(Description)"
                            />
                        </xsl:with-param>
                    </xsl:call-template>  
                    <dc:bibliographicCitation>
                        <xsl:value-of select="normalize-space(bibliographicCitation)"/>
                    </dc:bibliographicCitation>
                    <!-- this portion crosswalks the Excel element source to the dc:source element -->
                    <dcterms:isPartOf>Tufts University faculty scholarship.</dcterms:isPartOf>
                    <!-- this portion crosswalks the Excel element source to the dc:source element -->
                    <dc:source>
                        <xsl:value-of select="normalize-space(Source)"/>
                    </dc:source>
                    <!-- this portion crosswalks the Excel element abstract to the dc:abstract element -->
                    <dcterms:abstract>
                        <xsl:value-of select="normalize-space(abstract)"/>
                    </dcterms:abstract>
                    <!-- this portion inserts the boilerplate publisher information -->
                    <dc:publisher>Tufts University. Tisch Library.</dc:publisher>
                    <!-- this portion crosswalks the Excel element datefrom to the dc:date.created element and strips out any non-numeric data -->
                    <dc:date.created>
                        <xsl:value-of select="replace(Date_Created,'[^.0-9]','')"/>
                    </dc:date.created>
                    <!-- this portion inserts the dc:type element depending on the following format -->
                    <dc:type>
                        <xsl:value-of select="normalize-space(Type)"/>
                    </dc:type>
                    <!-- this portion crosswalks the Excel element format to the dc:format element NB may need to normalize text here -->
                    <dc:format>
                        <xsl:value-of select="normalize-space(lower-case(Format))"/>
                    </dc:format>
                    
                    <!-- this portion crosswalks the Excel element subject terms to the dcadesc:subject element -->
                    <xsl:call-template name="SubjectSplit">
                        <xsl:with-param name="subjectText">
                            <xsl:value-of select="normalize-space(Subject)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element personalNames to the dcadesc:persname element -->
                    <xsl:call-template name="persNames">
                        <xsl:with-param name="persText">
                            <xsl:value-of select="normalize-space(personalNames)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element corporateNames to the dcadesc:corpname element -->
                    <xsl:call-template name="corpNames">
                        <xsl:with-param name="corpText">
                            <xsl:value-of select="normalize-space(corporateNames)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element geographicTerms to the dcadesc:geog element -->
                    <xsl:call-template name="geogNames">
                        <xsl:with-param name="geogText">
                            <xsl:value-of select="geographicTerms"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element genre to the dcadesc:genre element -->
                    <xsl:call-template name="GenreSplit">
                        <xsl:with-param name="genreText">
                            <xsl:value-of select="normalize-space(Genre)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element medium to the dcadesc:genre element -->
                    <xsl:choose>
                        <xsl:when test="medium/text()">
                            <dcadesc:genre>Medium: <xsl:value-of
                                select="normalize-space(replace(medium,'\.$',''))"
                            />.</dcadesc:genre>
                        </xsl:when>
                        <xsl:otherwise> </xsl:otherwise>
                    </xsl:choose>
                    <!-- this portion crosswalks the Excel element temporal -->       
                    <xsl:call-template name="TemporalSplit">
                        <xsl:with-param name="temporalText">
                            <xsl:value-of select="normalize-space(replace(Century,'\..$',''))"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element spatial -->    
                    <xsl:call-template name="SpatialSplit">
                        <xsl:with-param name="SpatialSplitText">
                            <xsl:value-of select="normalize-space(Spatial)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element rights to the dc:rights element -->
                    <dc:rights>http://sites.tufts.edu/dca/research-help/copyright-and-citations/</dc:rights>
                    <!-- this portion inserts the boilerplate steward information -->
                    <admin:steward>tisch</admin:steward>
                    <!-- this portion inserts the boilerplate batch template information -->
                    <ac:name>amay02</ac:name>
                    <ac:comment>FacultyScholarshipTransform: <xsl:value-of  select="current-dateTime()"/></ac:comment>
                    <ac:comment>
                        <xsl:value-of select="normalize-space(Rights)"/> 
                    </ac:comment>
                    <admin:createdby>externalXSLT</admin:createdby>
                    <!-- this portion inserts the boilerplate batch displays information -->                   
                    <admin:displays>dl</admin:displays>
                    <!-- this portion inserts embargo information -->  
                    <admin:embargo><xsl:value-of select="normalize-space(Embargo)"/></admin:embargo>
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
</xsl:stylesheet>