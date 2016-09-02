<?xml version="1.0" encoding="UTF-8"?>
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2016-01-01
UPDATED ON: 2016-01-20
This stylesheet converts the Fedora Object XML (FOXML) to a comma delimited file.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rel="info:fedora/fedora-system:def/relations-external#"
    xmlns:alex="http:alex.edu"
    xmlns:xlink="http://www.w3.org/1999/xlink">   
    
  
    <!-- Output as a text file -->
    <xsl:output method="text" indent="yes" use-character-maps="killSmartPunctuation"
        encoding="UTF-8"/>
    <xsl:character-map name="killSmartPunctuation">
        <xsl:output-character character="“" string="'"/>
        <xsl:output-character character="”" string="'"/>
        <xsl:output-character character="’" string="'"/>
        <xsl:output-character character="‘" string="'"/>
        <xsl:output-character character="&#x2013;" string="-"/>
        <xsl:output-character character="&#x2019;" string="'"/>
        <xsl:output-character character="&#x201C;" string="'"/> 
        <xsl:output-character character="&#x201D;" string="'"/>  
        <xsl:output-character character="&quot;" string="'"/>  
    </xsl:character-map>
    <xsl:template match="/">**pid**&#009;**Title**&#009;**Alternative_Title**&#009;**Creator**&#009;**Contributors**&#009;**Description**&#009;**Source**&#009;**Date_Created**&#009;**Type**&#009;**Format**&#009;**Subject**&#009;**personalNames**&#009;**corporateNames**&#009;**geographicTerms**&#009;**Genre**&#009;**Century**&#009;**Spatial**&#xD;<xsl:for-each select="/items/digitalObject">**<xsl:for-each select=".//pid"
            ><xsl:value-of select="."/></xsl:for-each>**&#009;**<xsl:for-each
                select=".//dc:title"><xsl:value-of select="."/></xsl:for-each>**&#009;<xsl:choose>

                    <xsl:when test=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='alternative'][not(position() = last())]">**<xsl:for-each
                        select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='alternative'][not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='alternative'][position() = last()]"/>**&#009;</xsl:when>
                    <xsl:otherwise>**<xsl:value-of select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='alternative']"/>**&#009;</xsl:otherwise></xsl:choose><xsl:choose>
                <xsl:when test=".//dc:creator[not(position() = last())]">**<xsl:for-each
                        select=".//dc:creator[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//dc:creator[position() = last()]"/>**&#009;</xsl:when>
                    <xsl:otherwise>**<xsl:value-of select=".//dc:creator"/>**&#009;</xsl:otherwise>
                    </xsl:choose><xsl:choose>
                        <xsl:when test=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='contributor'][not(position() = last())]">**<xsl:for-each
                            select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='contributor'][not(position() = last())]"><xsl:value-of
                                select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                    select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='acontributor'][position() = last()]"/>**&#009;</xsl:when>
                        <xsl:otherwise>**<xsl:value-of select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='contributor']"/>**&#009;</xsl:otherwise>
                    </xsl:choose>
        <xsl:choose>
            <xsl:when test=".//dc:description[not(position() = last())]">**<xsl:for-each
                select=".//dc:description[not(position() = last())]"><xsl:value-of
                    select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dc:description[position() = last()]"/>**&#009;</xsl:when>
            <xsl:otherwise>**<xsl:value-of select=".//dc:description"/>**&#009;</xsl:otherwise></xsl:choose>**<xsl:for-each select=".//dc:source"><xsl:value-of select="."/></xsl:for-each>**&#009;**<xsl:for-each
                select=".//dc:date.created"><xsl:value-of select="."/></xsl:for-each>**&#009;**<xsl:for-each select=".//dc:type"><xsl:value-of select="."/></xsl:for-each>**&#009;**<xsl:for-each select=".//dc:format"><xsl:value-of select="."/></xsl:for-each>**&#009;<xsl:choose>
                    <xsl:when test=".//dcadesc:subject[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:subject[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//dcadesc:subject[position() = last()]"/>**&#009;</xsl:when>
                    <xsl:otherwise>**<xsl:value-of select=".//dcadesc:subject"
                    />**&#009;</xsl:otherwise>
                </xsl:choose><xsl:choose>
                <xsl:when test=".//dcadesc:persname[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:persname[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//dcadesc:persname[position() = last()]"/>**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:persname"
                />**&#009;</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dcadesc:corpname[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:corpname[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//dcadesc:corpname[position() = last()]"/>**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:corpname"
                />**&#009;</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dcadesc:geogname[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:geogname[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//dcadesc:geogname[position() = last()]"/>**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:geogname"
                />**&#009;</xsl:otherwise>
            </xsl:choose>  
        <xsl:choose>
            <xsl:when test=".//dcadesc:genre[not(position() = last())]">**<xsl:for-each
                select=".//dcadesc:genre[not(position() = last())]"><xsl:value-of
                    select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dcadesc:genre[position() = last()]"/>**&#009;</xsl:when>
            <xsl:otherwise>**<xsl:value-of select=".//dcadesc:genre"
            />**&#009;</xsl:otherwise>
        </xsl:choose><xsl:choose>
            <xsl:when test=".//dc:temporal[not(position() = last())]">**<xsl:for-each
                select=".//dc:temporal[not(position() = last())]"><xsl:value-of
                    select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dc:temporal[position() = last()]"/>**&#009;</xsl:when>
            <xsl:otherwise>**<xsl:value-of select=".//dc:temporal"
            />**&#009;</xsl:otherwise> 
        </xsl:choose><xsl:choose>
            <xsl:when test=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='spatial'][not(position() = last())]">**<xsl:for-each
                select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='spatial'][not(position() = last())]"><xsl:value-of
                    select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='spatial'][position() = last()]"/>**&#009;</xsl:when>
            <xsl:otherwise>**<xsl:value-of select=".//datastream/dc:dc/*[namespace-uri()='http://purl.org/d/terms/' and local-name()='spatial']"
                />**&#xD;</xsl:otherwise> 
        </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
