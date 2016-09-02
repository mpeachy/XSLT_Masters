<?xml version="1.0" encoding="UTF-8"?>

<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2014-07-07
UPDATED ON: 2014-08-05

This stylesheet converts the EDT Excel file to qualified Dublin Core based on the mappings found in the MIRA data dictionary.
-->

<!-- If title case proves necesssary put this between the dc:title elements <xsl:value-of select="alex:fnTitleCase(normalize-space(replace(title,'\.$','')))"/> -->

<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:alex="http:alex.edu">
    <!--This calls the named templates found in the following xslt(s) for parsing specific fields into approprite data for ingest  -->
    <xsl:import href="../../../Helpers/SplitField_helper.xslt"/>
    <xsl:import href="../../../Helpers/Filename_helper.xslt"/>
    <xsl:import href="../../../Helpers/creatorDept_helper.xsl"/>
    <!--This changes the output to xml -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <!-- this starts the crosswalk-->
    <xsl:template match="/">
        <input>
            <xsl:for-each select="root/row">
                <digitalObject xmlns:dc="http://purl.org/dc/elements/1.1/"
                    xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
                    xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/"
                    xmlns:dcterms="http://purl.org/dc/terms/"
                    xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/"
                    xmlns:ac="http://purl.org/dc/dcmitype/"
                    xmlns:rel="info:fedora/fedora-system:def/relations-external#">
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
                    <!-- this portion crosswalks the Excel element pid to the pid -->
                    <pid>
                        <xsl:value-of select="normalize-space(pid)"/>
                    </pid>
                    <!-- this portion crosswalks the Excel element title to the dc:title element -->
                    <dc:title>
                        <xsl:value-of select="normalize-space(replace(title,'\.$',''))"
                        />.</dc:title>
                    <!-- this portion crosswalks the Excel element creators to the dc:creator element -->
                    <xsl:call-template name="CreatorSplit">
                        <xsl:with-param name="creatorText">
                            <xsl:value-of select="normalize-space(creators)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element description and the abstract to the dc:description element -->
                    <dc:description>
                        <xsl:value-of
                            select="normalize-space(replace(description,'\.$|.$','.&#160;'))"/>
                        <xsl:choose>
                            <xsl:when test="abstract[contains(text(),text())]">Abstract: <xsl:value-of select="normalize-space(replace(abstract,'\.$','.'))"/></xsl:when>
                        </xsl:choose>
                    </dc:description>
                    <!-- this portion crosswalks the Excel element abstract to the dc:abstract element and will be intialized at a later date
                    <dcterms:abstract>
                        <xsl:value-of
                            select="normalize-space(replace(abstract,'\.$',' '))"
                        />.</dcterms:abstract>
                    -->
                    <!-- this portion inserts the boilerplate publisher information -->
                    <dc:publisher>Tufts University. Digital Collections and Archives.</dc:publisher>
                    <!-- this portion crosswalks the Excel element datefrom to the dc:date.created element -->
                    <dc:date.created>
                        <xsl:value-of select="normalize-space(datefrom)"/>
                    </dc:date.created>
                    <!-- this portion creates the dc:date.available element -->
                    <dc:date.available>
                        <xsl:value-of select="current-date()"/>
                    </dc:date.available>
                    <!-- this portion inserts the dc:type element depending on the following format -->
                    <xsl:choose>
                        <xsl:when test="format='application/mp3'">
                            <dc:type>Sound</dc:type>
                        </xsl:when>
                        <xsl:when test="format='application/mp4'">
                            <dc:type>MovingImage</dc:type>
                        </xsl:when>
                        <xsl:when test="format='image/tiff'">
                            <dc:type>Image</dc:type>
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:type>Text</dc:type>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- this portion crosswalks the Excel element format to the dc:format element -->
                    <dc:format>
                        <xsl:value-of select="normalize-space(format)"/>
                    </dc:format>
                    <!-- this portion crosswalks the Excel element topicTerms to the dcadesc:subject element -->
                    <xsl:call-template name="SubjectSplit">
                        <xsl:with-param name="subjectText">
                            <xsl:value-of select="normalize-space(topicTerms)"/>
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
                            <xsl:value-of select="normalize-space(geographicTerms)"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <!-- this portion crosswalks the Excel element rights to the dc:rights element -->
                    <dc:rights>
                        <xsl:value-of select="normalize-space(rights)"/>
                    </dc:rights>

                    <!-- this portion crosswalks the rel:isMemberOf and hasDescription; remove before next ingest for following FY-->
                    <xsl:choose>
                        <xsl:when test="topicTerms [contains(text(),'Senior honors thesis')]">
                            <rel:isMemberOf>tufts:UA069.001.DO.UA005</rel:isMemberOf>
                            <rel:hasDescription>tufts:UA069.001.DO.UA005</rel:hasDescription>
                        </xsl:when>
                        <xsl:when test="topicTerms [contains(text(),'MALD thesis')]">
                            <rel:isMemberOf>tufts:UA069.001.DO.UA015</rel:isMemberOf>
                            <rel:hasDescription>tufts:UA069.001.DO.UA015</rel:hasDescription>
                        </xsl:when>
                        <xsl:when test="topicTerms [contains(text(),'MIB thesis')]">
                            <rel:isMemberOf>tufts:UA069.001.DO.UA015</rel:isMemberOf>
                            <rel:hasDescription>tufts:UA069.001.DO.UA015</rel:hasDescription>
                        </xsl:when>
                        <xsl:when test="topicTerms [contains(text(),'LLM thesis')]">
                            <rel:isMemberOf>tufts:UA069.001.DO.UA015</rel:isMemberOf>
                            <rel:hasDescription>tufts:UA069.001.DO.UA015</rel:hasDescription>
                        </xsl:when>
                        <xsl:when
                            test="topicTerms [contains(text(),'Tisch Library Undergraduate Research Award')]">
                            <rel:isMemberOf>tufts:UA069.001.DO.UA137</rel:isMemberOf>
                            <rel:hasDescription>tufts:UA069.001.DO.UA137</rel:hasDescription>
                        </xsl:when>
                        <xsl:otherwise>
                            <rel:isMemberOf>tufts:UA069.001.DO.PB</rel:isMemberOf>
                            <rel:hasDescription>tufts:UA069.001.DO.PB</rel:hasDescription>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- this portion inserts the boilerplate steward information -->
                    <admin:steward>dca</admin:steward>
                    <!-- this portion inserts the boilerplate batch template information -->
                    <ac:name>EDTBatchTemplate</ac:name>
                    <!-- this portion inserts the boilerplate batch displays information -->
                    <admin:displays>tisch</admin:displays>
                    <admin:displays>dl</admin:displays>
                    <!-- this portion inserts the boilerplate QR note information -->
                    <admin:note>User submitted using self submission tool.</admin:note>
                    <!-- this portion inserts the boilerplate created by information -->
                    <admin:createdby>selfdep</admin:createdby>
                    <!-- this portion inserts the admin:creatordept element -->
                    <admin:creatordept><xsl:value-of select="normalize-space(parent)"/></admin:creatordept>  
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
</xsl:stylesheet>
