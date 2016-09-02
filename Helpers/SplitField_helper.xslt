<?xml version="1.0" encoding="UTF-8"?>
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2014-07-07
UPDATED ON: 2014-09-25
This stylesheet creates a group of templates for normalizing data entry errors, which are called in the _RunThis xslts -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:ac="http://purl.org/dc/dcmitype/">
    <!-- this portion of the XSLT creates a named template for altTitle, identifies delimeters from the input file and splits them into seperate dcterms:alternative elements, 
       it also strips out any full stops-->
    <xsl:template name="altTitleSplit" match="text()">
        <xsl:param name="altTitleText" select="."/>
        <xsl:if test="string-length($altTitleText)">
            <xsl:if test="not($altTitleText=.)"> </xsl:if>
            <dcterms:alternative>
                <xsl:value-of
                    select="normalize-space(replace(substring-before(concat($altTitleText,'|'),'|'),'\..$',''))"
                />
            </dcterms:alternative>
            <xsl:call-template name="altTitleSplit">
                <xsl:with-param name="altTitleText" select="substring-after($altTitleText,'|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT creates a named template for creators, identifies delimeters from the input file and splits them into seperate dc:creator elements, 
       it also ensures that each creator ends with a full stop-->
    <xsl:template name="CreatorSplit" match="text()">
        <xsl:param name="creatorText" select="."/>
        <xsl:if test="string-length($creatorText)">
            <xsl:if test="not($creatorText=.)"> </xsl:if>
            <dc:creator>
                <xsl:value-of
                    select="normalize-space (replace(replace(substring-before(concat($creatorText,'|'),'|'),'(\w)$','$1.'),'\.+$','.'))"
                /></dc:creator>
            <xsl:call-template name="CreatorSplit">
                <xsl:with-param name="creatorText" select="replace(substring-after($creatorText, '|'),'([\..]$)','')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <!-- this portion of the XSLT creates a named template for creators, identifies delimeters from the input file and splits them into seperate dc:creator elements, 
       it also ensures that each creator ends with a full stop-->
    <xsl:template name="ContributorSplit" match="text()">
        <xsl:param name="contributorText" select="."/>
        <xsl:if test="string-length($contributorText)">
            <xsl:if test="not($contributorText=.)"> </xsl:if>
            <dcterms:contributor>
                <xsl:value-of
                    select="normalize-space(replace(substring-before(concat($contributorText,'|'),'|'),'(\w)$','$1.'))"
                /></dcterms:contributor>
            <xsl:call-template name="ContributorSplit">
                <xsl:with-param name="contributorText" select="replace(substring-after($contributorText, '|'),'([\..]$)','')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <!-- this portion of the XSLT splits the Description chunk into smaller bits, it also ensures each description ends in a full stop-->
    <xsl:template name="DescriptionSplit" match="text()">
        <xsl:param name="descriptionText" select="."/>
        <xsl:if test="string-length($descriptionText)">
            <xsl:if test="not($descriptionText=.)"> </xsl:if>
            <dc:description>
                <xsl:value-of
                    select="replace(replace(replace(normalize-space(replace(substring-before(concat($descriptionText,'|'),'|'),'Description:','')),'([\w]$)','$1.'), '\)\.',')'),'\.+$','.')"
                /></dc:description>
            <xsl:call-template name="DescriptionSplit">
                <xsl:with-param name="descriptionText"
                    select="substring-after($descriptionText, '|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT creates a named template for topic subjects, identifies delimeters from the input file and splits them into seperate dcadesc:subject elements, 
        it also normalizes spacing between headings,and ensures each term ends with either a full-stop or closing parens-->
    <xsl:template name="SubjectSplit" match="text()">
        <xsl:param name="subjectText" select="."/>
        <xsl:if test="string-length($subjectText)">
            <xsl:if test="not($subjectText=.)"> </xsl:if>
            <dcadesc:subject>
                <xsl:value-of
                    select="replace(replace(replace(normalize-space(replace(substring-before(concat($subjectText,'|'),'|'),'(\s\-\-\s)|(\s\-\s)|(\s\-\-)|(\-\-\s)','--')),'([\w]$)','$1.'), '\)\.',')'),'\.+$','.')"
                />
            </dcadesc:subject>
            <xsl:call-template name="SubjectSplit">
                <xsl:with-param name="subjectText" select="substring-after($subjectText, '|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT creates a named template for personal name subjects, identifies delimeters from the input file  and splits them into seperate dcadesc:persname elements, 
        it normalizes spacing between headings,and ensures each term ends with either a full-stop or closing parens-->
    <xsl:template name="persNames" match="text()">
        <xsl:param name="persText" select="."/>
        <xsl:if test="string-length($persText)">
            <xsl:if test="not($persText=.)"> </xsl:if>
            <dcadesc:persname>
                <xsl:value-of
                    select="replace(normalize-space(replace(substring-before(concat($persText,'|'),'|'),'(\s\-\-\s)|(\s\-\s)|(\s\-\-)|(\-\-\s)','--')),'(\w)$','$1.')"
                />
            </dcadesc:persname>
            <xsl:call-template name="persNames">
                <xsl:with-param name="persText" select="substring-after($persText, '|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT creates a named template for corporate name subjects which identifies delimeters from the input file allows for their replacement-->
    <xsl:template name="corpNames" match="text()">
        <xsl:param name="corpText" select="."/>
        <xsl:if test="string-length($corpText)">
            <xsl:if test="not($corpText=.)"> </xsl:if>
            <dcadesc:corpname>
                <xsl:value-of
                    select="replace(replace(normalize-space(replace(substring-before(concat($corpText,'|'),'|'),'(\s\-\-\s)|(\s\-\s)|(\s\-\-)|(\-\-\s)','--')),'([a-z]$)','$1.'), '\)\.',')')"
                />
            </dcadesc:corpname>
            <xsl:call-template name="corpNames">
                <xsl:with-param name="corpText" select="substring-after($corpText, '|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT creates a named template for geographic name subjects which identifies delimeters from the input file allows for their replacement-->
    <xsl:template name="geogNames" match="text()">
        <xsl:param name="geogText" select="."/>
        <xsl:if test="string-length($geogText)">
            <xsl:if test="not($geogText=.)"> </xsl:if>
            <dcadesc:geogname>
                <xsl:value-of
                    select="replace(replace(normalize-space(replace(substring-before(concat($geogText,'|'),'|'),'(\s\-\-\s)|(\s\-\s)|(\s\-\-)|(\-\-\s)','--')),'([a-z]$)','$1.'), '\)\.',')')"
                />
            </dcadesc:geogname>
            <xsl:call-template name="geogNames">
                <xsl:with-param name="geogText" select="substring-after($geogText, '|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT identifies pipe delimeters from the input file at 'Genre' and splits it into small bits-->
    <xsl:template name="GenreSplit" match="text()">
        <xsl:param name="genreText" select="."/>
        <xsl:if test="string-length($genreText)">
            <xsl:if test="not($genreText=.)"> </xsl:if>
            <dcadesc:genre>
                <xsl:value-of
                    select="replace(replace(normalize-space(replace(substring-before(concat($genreText,'|'),'|'),'(\s\-\-\s)|(\s\-\s)|(\s\-\-)|(\-\-\s)','--')),'([a-z]$)','$1.'), '\)\.',')')"
                />
            </dcadesc:genre>
            <xsl:call-template name="GenreSplit">
                <xsl:with-param name="genreText" select="substring-after($genreText, '|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT identifies pipe delimeters from the input file at 'temporal' and splits it into small bits-->
    <xsl:template name="TemporalSplit" match="text()">
        <xsl:param name="temporalText" select="."/>
        <xsl:if test="string-length($temporalText)">
            <xsl:if test="not($temporalText=.)"> </xsl:if>
            <dc:temporal>
                <xsl:value-of
                    select="normalize-space(replace(substring-before(concat($temporalText,'|'),'|'),'\..$',''))"
                />.</dc:temporal>
            <xsl:call-template name="TemporalSplit">
                <xsl:with-param name="temporalText" select="replace(substring-after($temporalText, '|'),'([\..]$)','')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <!-- this portion of the XSLT identifies pipe delimeters from the input file at 'spatial' and splits it into small bits-->  
    <xsl:template name="SpatialSplit" match="text()">
        <xsl:param name="SpatialSplitText" select="."/>
        <xsl:if test="string-length($SpatialSplitText)">
            <xsl:if test="not($SpatialSplitText=.)"> </xsl:if>
            <dc:spatial>
                <xsl:value-of
                    select="replace(normalize-space(replace(substring-before(concat($SpatialSplitText,'|'),'|'),'(\s\-\-\s)|(\s\-\s)|(\s\-\-)|(\-\-\s)','--')),'([\w]$)','$1.')"
                /></dc:spatial>
            <xsl:call-template name="SpatialSplit">
                <xsl:with-param name="SpatialSplitText" select="substring-after($SpatialSplitText, '|')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template> 
    <!--This portion of the XSLT identifies pipe delimeters from the input file at the 'AdministrativeNote' and splites it into small bits-->
    <xsl:template name="AdminNoteSplit" match="text()">
        <xsl:param name="adminText" select="."/>
        <xsl:if test="string-length($adminText)">
            <xsl:if test="not($adminText=.)"> </xsl:if>
            <ac:comment>
                <xsl:value-of
                    select="normalize-space(replace(substring-before(concat($adminText,'|'),'|'),'\..$',''))"
                />.</ac:comment>
            <xsl:call-template name="AdminNoteSplit">
                <xsl:with-param name="adminText" select="replace(substring-after($adminText, '|'),'([\..]$)','')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
   
</xsl:stylesheet>
