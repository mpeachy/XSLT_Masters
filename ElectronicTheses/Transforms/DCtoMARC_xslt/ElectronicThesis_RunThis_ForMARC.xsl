<?xml version="1.0" encoding="UTF-8"?>
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2014-07-18
UPDATED ON: 2014-12-18
This stylesheet converts the qualified Dublin Core used by the Tufts Repository to MARC.
-->
<!--Name space declarations and XSLT version -->
<xsl:stylesheet version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns="http://www.loc.gov/MARC21/slim" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="dc" xmlns:rel="info:fedora/fedora-system:def/relations-external#"
    xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/">
    <xsl:output method="xml" indent="yes" use-character-maps="killSmartPunctuation" encoding="UTF-8"/>
    <xsl:character-map name="killSmartPunctuation">
        <xsl:output-character character="“" string="&quot;"/>
        <xsl:output-character character="”" string="&quot;"/>
        <xsl:output-character character="’" string="'"/>
        <xsl:output-character character="‘" string="'"/>
        <xsl:output-character character="&#x2013;" string="-"/>
        <xsl:output-character character=":" string=":"/>
    </xsl:character-map>
    <xsl:template match="/">
        <marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
            <xsl:for-each select="./items/digitalObject">
                <marc:record>
                    <marc:leader>00000nam  2200361Ii 4500</marc:leader>
                    <marc:controlfield tag="006">m|||||o||d |||||||</marc:controlfield>
                    <marc:controlfield tag="007">cr |||||||||||</marc:controlfield>
                    <marc:controlfield tag="008">130321s2014\\\\xxu\\\\\om\\\\\\\\\\eng\d</marc:controlfield>
                    <marc:datafield tag="040" ind1="" ind2="">
                        <marc:subfield code="a">TFW</marc:subfield>
                        <marc:subfield code="b">eng</marc:subfield>
                        <marc:subfield code="e">rda</marc:subfield>
                        <marc:subfield code="c">TFW</marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="042" ind1="" ind2="">
                        <marc:subfield code="a">dc</marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="100" ind1="1" ind2="">
                        <marc:subfield code="a">
                            <xsl:value-of select=".//dc:creator [1]"/>
                        </marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="245" ind1="1" ind2="0">
                        <marc:subfield code="a">
                            <xsl:value-of select="replace(.//dc:title[1], '(\w)$','$1 /')"/>
                        </marc:subfield><marc:subfield code="c">
                            <xsl:value-of select="replace(replace(substring-after(.//dc:creator[1],', '), '[\..]$', ' '),'(\w)$','$1 ')"/>
                            <xsl:value-of select="substring-before(.//dc:creator[1],', ')"/>.</marc:subfield>
                    </marc:datafield>
                    <xsl:for-each select=".//dc:title[position()>1]">
                        <marc:datafield tag="246" ind1="3" ind2="3">
                            <marc:subfield code="a">
                                <xsl:value-of select="."/>
                            </marc:subfield>
                        </marc:datafield>
                    </xsl:for-each>
                    <marc:datafield tag="264" ind1="" ind2="1">
                        <marc:subfield code="c">
                            <xsl:value-of select=".//dc:date.created"/>.</marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="300" ind1="" ind2="">
                        <marc:subfield code="a">1 online resource.</marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="336" ind1="" ind2="">
                        <marc:subfield code="a">text</marc:subfield>
                        <marc:subfield code="b">txt</marc:subfield>
                        <marc:subfield code="2">rdacontent</marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="337" ind1="" ind2="">
                        <marc:subfield code="a">computer</marc:subfield>
                        <marc:subfield code="b">c</marc:subfield>
                        <marc:subfield code="2">rdamedia</marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="338" ind1="" ind2="">
                        <marc:subfield code="a">online resource</marc:subfield>
                        <marc:subfield code="b">cr</marc:subfield>
                        <marc:subfield code="2">rdacarrier</marc:subfield>
                    </marc:datafield>
                    <marc:datafield tag="500" ind1="" ind2="">
                        <marc:subfield code="a"><xsl:value-of select="substring-after(rel:isMemberOf,'tufts:')"/>
                        </marc:subfield>
                    </marc:datafield>
                    <xsl:choose>
                        <xsl:when test=".//dcadesc:corpname [contains(text(),'Perseus Project.')]">
                    <marc:datafield tag="502" ind1="" ind2="">
                        <marc:subfield code="a">Perseus Project -- Tufts University, <xsl:value-of select="dc:date.created"/>.</marc:subfield>
                    </marc:datafield>
                        </xsl:when>
                        
                    </xsl:choose>
                    <marc:datafield tag="520" ind1="" ind2="">
                        <marc:subfield code="a"><xsl:value-of select="normalize-space(.//dc:description)"/>
                        </marc:subfield>
                    </marc:datafield>
                    
                    <xsl:for-each select=".//dcadesc:persname">
                        <marc:datafield tag="600" ind1="1" ind2="0">
                            <marc:subfield code="a">
                                <xsl:value-of select="normalize-space(replace(.,'--','&lt;/marc:subfield&gt;&lt;marc:subfield code=&quot;x&quot;&gt;'))"/>
                            </marc:subfield>
                        </marc:datafield>
                    </xsl:for-each>
                    
                    
                    <xsl:choose>
                        <xsl:when test=".//dcadesc:corpname [contains(text(),'Perseus Project.')]">
    
                        </xsl:when>  
                        <xsl:otherwise>
                            <xsl:for-each select=".//dcadesc:corpname">
                                <marc:datafield tag="710" ind1="1" ind2="0">
                                    <marc:subfield code="a">
                                        <xsl:value-of select="normalize-space(replace(.,'--','&lt;/marc:subfield&gt;&lt;marc:subfield code=&quot;x&quot;&gt;'))"/>
                                    </marc:subfield>
                                </marc:datafield>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:choose>
                        
                        
                        <xsl:when test=".//dcadesc:corpname [contains(text(),'Perseus Project.')]">
                            <xsl:for-each select=".//dcadesc:subject">
                                <marc:datafield tag="650" ind1="" ind2="">
                                    <marc:subfield code="a">
                                        <xsl:value-of select="normalize-space(replace(.,'--','&lt;/marc:subfield&gt;&lt;marc:subfield code=&quot;x&quot;&gt;'))"/>
                                    </marc:subfield>
                                </marc:datafield>
                            </xsl:for-each>   
                        </xsl:when>
                        
                        <xsl:otherwise>
                            <xsl:for-each select=".//dcadesc:subject">
                                <marc:datafield tag="650" ind1="" ind2="0">
                                    <marc:subfield code="a">
                                        <xsl:value-of select="normalize-space(replace(.,'--','&lt;/marc:subfield&gt;&lt;marc:subfield code=&quot;x&quot;&gt;'))"/>
                                    </marc:subfield>
                                </marc:datafield>
                            </xsl:for-each>
                        </xsl:otherwise> 
                    </xsl:choose>
                    <xsl:for-each select=".//dcadesc:geogname">
                        <marc:datafield tag="651" ind1="" ind2="0">
                            <marc:subfield code="a">
                                <xsl:value-of select="normalize-space(replace(.,'--','&lt;/marc:subfield&gt;&lt;marc:subfield code=&quot;x&quot;&gt;'))"/>
                            </marc:subfield>
                        </marc:datafield>
                    </xsl:for-each>
                    <xsl:choose>
                        <xsl:when test=".//dcadesc:corpname [contains(text(),'Perseus Project.')]">
                            <marc:datafield tag="655" ind1="" ind2="7">
                                <marc:subfield code="a">Tufts published scholarship.</marc:subfield>
                                <marc:subfield code="2">local</marc:subfield>
                            </marc:datafield>
                        </xsl:when>
                        <xsl:otherwise>
                            <marc:datafield tag="655" ind1="" ind2="7">
                                <marc:subfield code="a">Electronic dissertations.</marc:subfield>
                                <marc:subfield code="2">lcgft</marc:subfield>
                            </marc:datafield>
                            <marc:datafield tag="655" ind1="" ind2="7">
                                <marc:subfield code="a">Tufts dissertations and theses.</marc:subfield>
                                <marc:subfield code="2">local</marc:subfield>
                            </marc:datafield>                       
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:for-each select=".//dc:creator[position()>1]">
                        <marc:datafield tag="700" ind1="1" ind2="">
                            <marc:subfield code="a">
                                <xsl:value-of select="."/>
                            </marc:subfield>
                        </marc:datafield>
                    </xsl:for-each>
                    
                    
                    <xsl:for-each select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='isPartOf']">
                        <marc:datafield tag="590" ind1="" ind2="">
                            <marc:subfield code="a">
                                <xsl:value-of select="."/>
                            </marc:subfield>
                        </marc:datafield>
                    </xsl:for-each>
                    <xsl:for-each select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='contributor']">
                        <marc:datafield tag="700" ind1="1" ind2="">
                            <marc:subfield code="a">
                                <xsl:value-of select="."/>
                            </marc:subfield>
                        </marc:datafield>
                    </xsl:for-each>
                    <xsl:choose>
                        <xsl:when test=".//dcadesc:subject [contains(text(),'Senior honors thesis.')]">
                            <marc:datafield tag="710" ind1="2" ind2="">
                                <marc:subfield code="a"><xsl:value-of select=".//dcadesc:subject[2]"/></marc:subfield>
                            </marc:datafield>     
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test=".//dcadesc:corpname[contains(text(),'Perseus Project.')]">
                            <marc:datafield tag="710" ind1="2" ind2="">
                                <marc:subfield code="a">Perseus Project.</marc:subfield>
                            </marc:datafield>     
                        </xsl:when>
                    </xsl:choose>
                    <marc:datafield tag="856" ind1="4" ind2="0"><marc:subfield code="z">Full Text -- Tufts Digital Library</marc:subfield><marc:subfield code="u"><xsl:value-of select=".//dc:identifier"/></marc:subfield></marc:datafield>
                    <marc:datafield tag="910" ind1="" ind2=""><marc:subfield code="a">Title also cataloged in DL.</marc:subfield></marc:datafield>
                </marc:record>
            </xsl:for-each>
        </marc:collection>
    </xsl:template>
</xsl:stylesheet>
