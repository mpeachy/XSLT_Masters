<?xml version="1.0" encoding="UTF-8"?>

<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2014-03-27
UPDATED ON: 2014-06-09

This stylesheet converts MARCXML to qualified Dublin Core based on the mappings found in the MIRA data dictionary.
After croswalking into the Dublin Core, please make sure you run the following RegEX in the Find/Repalce in your new XML document.  
Text to find: ^(.*)(?:(?:\r?\n|\r)\1)+$  
Replace with: $1  

This will remove any duplicate names which may crop up by removing relator terms from the 7xx fields.
-->

<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd"
    version="2.0">
    <!--This calls the named templates found in the following xslt(s) for parsing specific MARC fields into approprite data for ingest  -->
    <xsl:import href="../../../Helpers/MARC_helper.xslt"/>
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
            <xsl:for-each select="collection('xml/collection.xml')/marc:collection/marc:record">
                <digitalObject>
                    <!-- insert file name here -->
                    <xsl:choose>
                        <xsl:when
                            test="marc:datafield[@tag = '856']/marc:subfield[@code = 'u'][contains(text(), 'archive.org')]">
                            <file><xsl:value-of
                                    select="marc:datafield[@tag = '856']/marc:subfield[@code = 'u'][contains(text(), 'archive.org')]/replace(., '.*/', '')"
                                />.pdf</file>
                        </xsl:when>
                        <xsl:otherwise>
                            <file>.pdf</file>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- this portion crosswalks the rel:hasModel for pdfs as bolierplate -->
                    <rel:hasModel>info:fedora/cm:Text.PDF</rel:hasModel>
                    <!-- this portion crosswalks the MARC uniform title to the dc:title element, if a 240 does not exist, it croswallks the 245 -->
                    <dc:title>
                                <xsl:value-of
                                    select="normalize-space(replace(replace(marc:datafield[@tag = '245'], '\[electronic resource\]', ''), '(/|:|;|,)', '$1 '))"
                                />
                    </dc:title>
                    <!-- this portion crosswalks the MARC main author entry to the dc:creator element -->
                    <xsl:for-each
                        select="marc:datafield[@tag = '100'] | marc:datafield[@tag = '110'] | marc:datafield[@tag = '111'] | marc:datafield[@tag = '130']">
                        <dc:creator>
                            <xsl:call-template name="nameSelect">
                                <xsl:with-param name="delimeter">
                                    <xsl:text> </xsl:text>
                                </xsl:with-param>
                            </xsl:call-template>
                        </dc:creator>
                    </xsl:for-each>
                    <!-- this portion crosswalks general MARC notes to the dc:description element -->
                    <xsl:for-each select="marc:datafield[@tag = '250']">
                        <dc:description>
                            <xsl:value-of select="normalize-space(.)"/>
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks general MARC notes to the dc:description element -->
                    <xsl:for-each select="marc:datafield[@tag = '300']">
                        <dc:description>
                            <xsl:value-of
                                select="normalize-space(replace(replace(./replace(., '(\w )$', '$1.'), '(/|:|;|,)', '$1 '), '(\w)$', '$1.'))"
                            />
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks general MARC notes to the dc:description element -->
                    <xsl:for-each select="marc:datafield[@tag = '500']">
                        <dc:description>
                            <xsl:value-of
                                select="normalize-space(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"
                            />
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks a 'With' note to the dc:description element, and adds 'Bound with:' into the description -->
                    <xsl:for-each select="marc:datafield[@tag = '501']">
                        <dc:description>Bound with: <xsl:value-of
                                select="normalize-space(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"
                            />
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks the 533 to the dc:description element -->
                    <xsl:for-each select="marc:datafield[@tag = '533']">
                        <dc:description>
                            <xsl:value-of
                                select="normalize-space(replace(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''), '(:|;|,|\.)', '$1 '))"
                            />
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks a 'Binding' note to the dc:description element, and adds 'Binding:' into the description -->
                    <xsl:for-each select="marc:datafield[@tag = '563']">
                        <dc:description>Binding: <xsl:value-of
                                select="normalize-space(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"
                            />
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks a 'Indexed in' note to the dc:description element, and adds 'Indexed in:' into the description -->
                    <xsl:for-each select="marc:datafield[@tag = '510']">
                        <dc:description>Indexed in: <xsl:value-of select="normalize-space(.)"/>
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks a 'Series' to the dc:description element into the description -->
                    <xsl:for-each select="marc:datafield[@tag = '830']">
                        <dc:description>Series: <xsl:value-of
                                select="normalize-space(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"
                            />
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion crosswalks a '910' to the dc:description element into the description -->
                    <xsl:for-each
                        select="marc:datafield[@tag = '910']/marc:subfield[@code = 'a'][contains(text(), 'Tisch')]">
                        <dc:description>
                            <xsl:value-of select="normalize-space(./replace(., '.*/', ''))"/>
                        </dc:description>
                    </xsl:for-each>
                    <!-- this portion inserts the boilerplate publisher information -->
                    <dc:publisher>Tufts University. Tisch Library.</dc:publisher>
                    <!-- this portion crosswalks the MARC 776 DLC and OcLC numbers of the original print publication to the dc:source element -->
                    <xsl:choose>
                        <xsl:when
                            test="marc:datafield[@tag = '776']/marc:subfield[@code = 'w'][contains(text(), '(DLC)')]">
                            <dc:source>
                                <xsl:value-of
                                    select="normalize-space(substring-before(replace(marc:datafield[@tag = '776'], '(/|:|;|,|\.)', '$1 '), '(DLC)'))"
                                />.</dc:source>
                        </xsl:when>
                        <xsl:when
                            test="marc:datafield[@tag = '776']/marc:subfield[@code = 'w'][contains(text(), '(OCoLC)')]">
                            <dc:source>
                                <xsl:value-of
                                    select="normalize-space(substring-before(replace(marc:datafield[@tag = '776'], '(/|:|;|,|\.)', '$1 '), '(OCoLC)'))"
                                />.</dc:source>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    <!-- this portion crosswalks the MARC 776 of the original print publication to the dc:source element -->
                    <xsl:choose>
                        <xsl:when test="marc:datafield[@tag = '776']/marc:subfield[@code = 'w']">
                            <xsl:for-each
                                select="marc:datafield[@tag = '776']/marc:subfield[@code = 'w']">
                                <dc:source>
                                    <xsl:value-of select="normalize-space(.)"/>
                                </dc:source>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:source>Original print publication: <xsl:value-of
                                    select="normalize-space(marc:datafield[@tag = '260'])"
                                /></dc:source>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- crosswalks the bib number to the dc:source element -->
                    <xsl:choose>
                        <xsl:when test="marc:datafield[@tag = '050']">
                            <dc:source><xsl:value-of
                                select="normalize-space(marc:datafield[@tag = '050'])"/>
                            </dc:source>
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:source><xsl:value-of
                                select="normalize-space(marc:datafield[@tag = '090'])"/></dc:source>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- this portion crosswalks the first date from the 008 leader to the date created element, and strips out the remaining numbers and digits -->
                    <dc:date.created>
                        <xsl:for-each select="marc:controlfield[@tag = '008']">
                            <xsl:value-of select="normalize-space(./replace(., '^.{7}|.{29}$', ''))"
                            />
                        </xsl:for-each>
                    </dc:date.created>
                    <!-- this portion inserts the boilerplate 'Text' for the type element -->
                    <dc:type>Text</dc:type>
                    <!-- this portion inserts the boilerplate 'application/pdf' for the format element -->
                    <dc:format>application/pdf</dc:format>
                    <!-- this portion calls the MARC_helper xslt and its template which replaces the delimeters with a space and crosswalks MARC 600s into the dcadesc:persname -->
                    <xsl:for-each select="marc:datafield[@tag = 600]">
                        <dcadesc:persname>
                            <xsl:call-template name="nameSelect">
                                <xsl:with-param name="delimeter">
                                    <xsl:text> </xsl:text>
                                </xsl:with-param>
                            </xsl:call-template>
                        </dcadesc:persname>
                    </xsl:for-each>
                    <!-- this portion calls the MARC_helper xslt and its template which replaces the delimeters with a double dash and crosswalks MARC 610 or 611 into the dcadesc:corpname -->
                    <xsl:for-each select="marc:datafield[@tag = 610] | marc:datafield[@tag = 611]">
                        <dcadesc:corpname>
                            <xsl:call-template name="subfieldSelect">
                                <xsl:with-param name="delimeter">--</xsl:with-param>
                            </xsl:call-template>
                        </dcadesc:corpname>
                    </xsl:for-each>
                    <!-- this portion calls the MARC_helper xslt and its template which replaces the delimeters with a double dash and crosswalks MARC 651s into the dcadesc:geog -->
                    <xsl:for-each select="marc:datafield[@tag = 651]">
                        <dcadesc:geogname>
                            <xsl:call-template name="subfieldSelect">
                                <xsl:with-param name="delimeter">--</xsl:with-param>
                            </xsl:call-template>
                        </dcadesc:geogname>
                    </xsl:for-each>
                    <!-- this portion calls the MARC_helper xslt and its template which replaces the delimeters with a double dash and crosswalks MARC 650s into the dcadesc:subject -->
                    <xsl:for-each select="marc:datafield[@tag = 650]">
                        <dcadesc:subject>
                            <xsl:call-template name="subfieldSelect">
                                <xsl:with-param name="delimeter">--</xsl:with-param>
                            </xsl:call-template>
                        </dcadesc:subject>
                    </xsl:for-each>
                    <!-- this portion calls the MARC_helper xslt and its template which replaces the delimeters with a double dash and crosswalks MARC 655s into the dcadesc:genre -->
                    <xsl:for-each select="marc:datafield[@tag = '655']">
                        <dcadesc:genre>
                            <xsl:call-template name="subfieldSelect">
                                <xsl:with-param name="delimeter">--</xsl:with-param>
                            </xsl:call-template>
                        </dcadesc:genre>
                    </xsl:for-each>
                    <!-- this portion crosswalks the first instance of MARC 655 $y to the temporal element, if there is no 655 $y, it does not populate -->
                    <xsl:for-each select="marc:datafield[@tag = '655']/marc:subfield[@code = 'y']">
                        <xsl:if test="position() = 1">
                            <dc:temporal>
                                <xsl:value-of select="normalize-space(.)"/>
                            </dc:temporal>
                        </xsl:if>
                    </xsl:for-each>
                    <!-- this portion crosswalks all 246s to the altenative element -->
                    <xsl:for-each select="marc:datafield[@tag = '240']">
                        <dcterms:alternative>
                            <xsl:value-of
                                select="normalize-space(replace(replace(., '\[electronic resource\]', ' '), '(/|:|;|,)', '$1 '))"
                            />
                        </dcterms:alternative>
                    </xsl:for-each>
                    
                    <xsl:for-each select="marc:datafield[@tag = '246']">
                        <dcterms:alternative>
                            <xsl:value-of
                                select="normalize-space(replace(replace(., '\[electronic resource\]', ' '), '(/|:|;|,)', '$1 '))"
                            />
                        </dcterms:alternative>
                    </xsl:for-each>
                    
                    <!-- this portion crosswalks all relevant 7xx to the contributor element and uses the MARC_helper xslt to parse subfields -->
                    <xsl:for-each
                        select="marc:datafield[@tag = '700'] | marc:datafield[@tag = '710'] | marc:datafield[@tag = '711'] | marc:datafield[@tag = '720']">
                        <dcterms:contributor>
                            <xsl:call-template name="nameSelect">
                                <xsl:with-param name="delimeter">
                                    <xsl:text> </xsl:text>
                                </xsl:with-param>
                            </xsl:call-template>
                        </dcterms:contributor>
                    </xsl:for-each>
                    <!-- this portion crosswalks the 520 to the abstract element -->
                    <xsl:for-each select="marc:datafield[@tag = '520']">
                        <dcterms:abstract>
                            <xsl:value-of select="normalize-space(.)"/>
                        </dcterms:abstract>
                    </xsl:for-each>
                    <!-- this portion crosswalks the 505 to the table of contents element -->
                    <xsl:for-each select="marc:datafield[@tag = '505']">
                        <dcterms:tableOfContents>Table of Contents: <xsl:value-of
                                select="normalize-space(.)"/>
                        </dcterms:tableOfContents>
                    </xsl:for-each>
                    <!-- this portion crosswalks the language from the 008 leader to the language element, and strips out the remaining numbers and digits -->
                    <dcterms:language>
                        <xsl:for-each select="marc:controlfield[@tag = '008']">
                            <xsl:value-of select="normalize-space(./replace(., '^.{35}|.{2}$', ''))"
                            />
                        </xsl:for-each>
                    </dcterms:language>
                    <!-- this portion crosswalks a 'Provenance' note to the dc:provenance element, and adds 'Provenance:' into the description -->
                    <xsl:for-each select="marc:datafield[@tag = '561']">
                        <dcterms:provenance>Provenance: <xsl:value-of
                                select="normalize-space(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"
                            />
                        </dcterms:provenance>
                    </xsl:for-each>
                    <!-- this portion crosswalks the Heirarchical place name tag to the spatial element-->
                    <xsl:for-each select="marc:datafield[@tag = '752']">
                        <xsl:if test="position() = 1">
                            <dcterms:spatial>
                                <xsl:call-template name="subfieldSelect">
                                    <xsl:with-param name="delimeter">--</xsl:with-param>
                                </xsl:call-template>
                            </dcterms:spatial>
                        </xsl:if>
                    </xsl:for-each>
                    <!-- this portion inserts boilerplate for the dc:rights element -->
                    <dc:rights>http://sites.tufts.edu/dca/research-help/copyright-and-citations/</dc:rights>
                    <!-- this portion inserts the boilerplate steward information -->
                    <admin:steward>tisch</admin:steward>
                    <!-- this portion inserts the boilerplate batch template information -->
                    <ac:name>amay02</ac:name>
                    <ac:comment>InternetArchiveBatchTransform: <xsl:value-of
                            select="current-dateTime()"/></ac:comment>
                    <admin:createdby>externalXSLT</admin:createdby>
                    <!-- this portion inserts the boilerplate batch displays information -->
                    <admin:displays>dl</admin:displays>
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
</xsl:stylesheet>
