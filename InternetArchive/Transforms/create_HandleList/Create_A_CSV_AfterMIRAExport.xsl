<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rel="info:fedora/fedora-system:def/relations-external#"
    xmlns:alex="http:alex.edu"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:import href="../../Helpers/Title_helper.xslt"/>
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
    <xsl:template match="/">
        **pid**,**title**,**creator**,**description**,**personal name**,**corporate name**,**geographic name**,**subject**,**department**,**embargo**,**has description**,**is member of** 
        <xsl:for-each select="/items/digitalObject">**<xsl:for-each select=".//pid"
                    ><xsl:value-of select="."/></xsl:for-each>**,**<xsl:for-each
                        select=".//dc:title"><xsl:value-of select="."/></xsl:for-each>**,<xsl:choose>
                <xsl:when test=".//dc:creator[not(position() = last())]">**<xsl:for-each
                        select=".//dc:creator[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dc:creator[position() = last()]"/>**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dc:creator"/>**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dc:description[not(position() = last())]">**<xsl:for-each
                        select=".//dc:description[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dc:description[position() = last()]"/>**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dc:description"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dcadesc:persname[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:persname[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dcadesc:persname[position() = last()]"/>**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:persname"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dcadesc:corpname[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:corpname[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dcadesc:corpname[position() = last()]"/>**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:corpname"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dcadesc:geogname[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:geogname[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dcadesc:geogname[position() = last()]"/>**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:geogname"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dcadesc:subject[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:subject[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                        select=".//dcadesc:subject[position() = last()]"/>**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:subject"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept'][not(position() = last())]"
                        >**<xsl:for-each
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept'][not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept'][position() = last()]"
                    />**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept']"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo'][not(position() = last())]"
                        >**<xsl:for-each
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo'][not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo'][position() = last()]"
                    />**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo']"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource[not(position() = last())]"
                        >**<xsl:for-each
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource[not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource[position() = last()]"
                    />**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource"
                    />**,</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource[not(position() = last())]"
                        >**<xsl:for-each
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource[not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource[position() = last()]"
                    />**,</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource"
                    />**&#xD;</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
