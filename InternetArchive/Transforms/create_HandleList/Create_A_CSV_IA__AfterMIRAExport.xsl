<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rel="info:fedora/fedora-system:def/relations-external#" xmlns:alex="http:alex.edu"
    xmlns:xlink="http://www.w3.org/1999/xlink">

    <!-- Output as a text file -->
    <xsl:output method="text" indent="yes" use-character-maps="killSmartPunctuation"
        encoding="UTF-16"/>
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
    <xsl:template match="/"> **handle**&#009;**volume**&#009;**call Number**&#009;**title**&#xD; <xsl:for-each
            select=".//digitalObject">
            <xsl:choose>
                <xsl:when test=".//dc:identifier">**<xsl:for-each select=".//dc:identifier"
                            ><xsl:value-of select="."
                    /></xsl:for-each>**&#009;</xsl:when><xsl:otherwise>**NO HANDLE**&#009;</xsl:otherwise></xsl:choose><xsl:choose><xsl:when
                    test=".//dc:description[contains(text(), 'Volume')]">**<xsl:for-each
                        select=".//dc:description[contains(text(), 'Volume')]"><xsl:value-of
                            select="."
                        />**&#009;</xsl:for-each></xsl:when><xsl:otherwise>** **&#009;</xsl:otherwise></xsl:choose><xsl:choose><xsl:when
                            test=".//dc:source[position() = last()]">**<xsl:for-each
                                select=".//dc:source[position() = last()]"><xsl:value-of
                                    select="."
                                />**&#009;</xsl:for-each></xsl:when></xsl:choose>**<xsl:value-of
                select=".//dc:title"/>**&#xD; </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
