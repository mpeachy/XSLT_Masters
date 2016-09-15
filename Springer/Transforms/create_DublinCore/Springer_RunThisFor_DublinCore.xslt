<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE Publisher PUBLIC "-//Springer-Verlag//DTD A++ V2.4//EN" "http://devel.springer.de/A++/V2.4/DTD/A++V2.4.dtd">
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2016-05-11
UPDATED ON: 2016-05-16
This stylesheet converts Springer metadata to qualified Dublin Core based on the mappings found in the MIRA data dictionary.-->
<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
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
            <xsl:for-each select="collection('xml/collection.xml')">
                <digitalObject>
                    <file><xsl:value-of select=".//JournalInfo/JournalID"/>_<xsl:value-of select="//RegistrationDate/Year"/>_Article_<xsl:value-of select="//ArticleID"/>.pdf</file>
                    <!-- this portion crosswalks the rel:hasModel for pdfs as bolierplate -->
                    <rel:hasModel>info:fedora/cm:Text.PDF</rel:hasModel>
                    <!-- this portion crosswalks the MARC uniform title to the dc:title element, if a 240 does not exist, it croswallks the 245 -->
                    <dc:title>
                        <xsl:value-of
                            select="normalize-space(replace(//ArticleTitle,'\.+$',''))"
                        /><xsl:text>.</xsl:text>
                    </dc:title>
                    <!-- this portion crosswalks the MARC main author entry to the dc:creator element -->
                    <xsl:for-each
                        select="//Author">
                        <xsl:choose>
                            <xsl:when test=".//GivenName[2]">
                                <dc:creator><xsl:value-of select="normalize-space(.//FamilyName)"/>, <xsl:value-of select="normalize-space(.//GivenName[1])"/><xsl:text> </xsl:text><xsl:value-of select="normalize-space(replace(.//GivenName[2],'\.+$',''))"/><xsl:text>.</xsl:text></dc:creator>
                            </xsl:when>
                        <xsl:otherwise>
                            <dc:creator><xsl:value-of select="normalize-space(.//FamilyName)"/>, <xsl:value-of select="normalize-space(.//GivenName[1])"/><xsl:text>.</xsl:text></dc:creator>
                        </xsl:otherwise> 
                        </xsl:choose>                      
                    </xsl:for-each>
                    <xsl:choose>
                        <xsl:when test="//AbstractSection[@ID]/Heading">
                            <dc:description>  
                                <xsl:value-of select="//AbstractSection[@ID][1]/Heading"/>: <xsl:value-of
                                    select="//AbstractSection[@ID][1]/Para"/> 
                            </dc:description>  
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:description>  
                            <xsl:value-of select="normalize-space(//Abstract/Heading)"/>: <xsl:value-of
                                select="//Abstract/Para"/> 
                                </dc:description>  
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test=".//KeywordGroup">
                            <dc:description>
                                <xsl:value-of select=".//KeywordGroup/Heading"/>: <xsl:for-each select=".//Keyword[not(position()=last())]"><xsl:value-of select="normalize-space(.)"/><xsl:text>, </xsl:text></xsl:for-each>
                                <xsl:if test=".//Keyword[last()]">
                                    <xsl:value-of select="normalize-space(.//Keyword[last()])"/><xsl:text>.</xsl:text>
                                </xsl:if>
                            </dc:description> 
                        </xsl:when>
                        <xsl:when test=".//AbbreviationGroup">
                            <dc:description>  
                                <xsl:text>Keywords: </xsl:text><xsl:for-each select=".//AbbreviationGroup/DefinitionList/DefinitionListEntry[not(position()=last())]"><xsl:value-of select="normalize-space(.//Para)"/><xsl:text>, </xsl:text></xsl:for-each>
                                <xsl:if test=".//AbbreviationGroup/DefinitionList/DefinitionListEntry[position()=last()]">
                                    <xsl:value-of select="normalize-space(replace(.//AbbreviationGroup/DefinitionList/DefinitionListEntry[last()]/Description/Para,'\.+$',''))"/><xsl:text>.</xsl:text>
                                </xsl:if>
                            </dc:description>  
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    <dc:description>Springer Open.</dc:description>
                    <dc:bibliographicCitation>
                        <xsl:value-of select="//AuthorGroup/Author[1]/AuthorName[1]/FamilyName[1]"/>, <xsl:value-of select="//AuthorGroup/Author[1]/AuthorName[1]/GivenName[1]"/><xsl:text>, </xsl:text>
                        <xsl:for-each
                            select="//Author[position()>1][not(position()=last())]"><xsl:value-of select=".//GivenName[1]"/><xsl:text> </xsl:text><xsl:if test=".//GivenName[2]"><xsl:value-of select="replace(.//GivenName[2],'\.+$','')"/><xsl:text>. </xsl:text></xsl:if><xsl:value-of select=".//FamilyName"/><xsl:text>, </xsl:text></xsl:for-each>
                        <xsl:if test=".//Author[position()>1][last()]">
                            <xsl:text>and </xsl:text><xsl:value-of select=".//Author[last()]/AuthorName/GivenName[1]"/><xsl:text> </xsl:text><xsl:if test="//Author[last()]/AuthorName/GivenName[2]"><xsl:value-of select="replace(//Author[last()]/AuthorName/GivenName[2],'\.+$','')"/><xsl:text>. </xsl:text></xsl:if><xsl:value-of select=".//Author[last()]/AuthorName/FamilyName"/><xsl:text>. </xsl:text>
                        </xsl:if>
                        <xsl:text>"</xsl:text><xsl:value-of
                            select="normalize-space(//ArticleTitle)"
                        /><xsl:text>."</xsl:text>
                       <em><xsl:value-of select=".//JournalTitle"/></em><xsl:text> </xsl:text><xsl:value-of
                           select=".//VolumeInfo/VolumeIDStart"/><xsl:text>, no. </xsl:text><xsl:value-of select=".//VolumeIssueCount"/><xsl:text>(</xsl:text><xsl:value-of select=".//CoverDate/Month"/><xsl:text>, </xsl:text> <xsl:value-of select=".//CoverDate/Year"/><xsl:text>): </xsl:text> <xsl:value-of select=".//ArticleInfo/ArticleFirstPage"/><xsl:text>-</xsl:text><xsl:value-of select=".//ArticleInfo/ArticleLastPage"/><xsl:text>.</xsl:text>
                    </dc:bibliographicCitation>
                    <!-- this portion crosswalks the Excel element source to the dc:source element -->
                    <dcterms:isPartOf>Tufts University faculty scholarship.</dcterms:isPartOf>
                    <!-- this portion inserts boilerplate for the dc:rights element -->
                    <dc:rights>http://sites.tufts.edu/dca/research-help/copyright-and-citations/</dc:rights>
                    <!-- this portion inserts the boilerplate steward information -->
                    <admin:steward>tisch</admin:steward>
                    <!-- this portion inserts the boilerplate batch template information -->
                    <ac:name>amay02</ac:name>
                    <ac:comment>SpringerBatchTransform: <xsl:value-of
                            select="current-dateTime()"/></ac:comment>
                    <admin:createdby>externalXSLT</admin:createdby>
                    <!-- this portion inserts the boilerplate batch displays information -->
                    <admin:displays>dl</admin:displays>
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
</xsl:stylesheet>
