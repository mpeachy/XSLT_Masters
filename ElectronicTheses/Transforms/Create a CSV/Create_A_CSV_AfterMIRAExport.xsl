<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rel="info:fedora/fedora-system:def/relations-external#"
    xmlns:alex="http:alex.edu"
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
    <xsl:template match="/">**pid**&#009;**title**&#009;**date created**&#009;**creator**&#009;**description**&#009;**abstract**&#009;**personal name**&#009;**corporate name**&#009;**geographic name**&#009;**subject**&#009;**ua department**&#009;**embargo**&#009;**has description**&#009;**is member of**&#xD;<xsl:for-each select="/items/digitalObject">**<xsl:for-each select=".//pid"
            ><xsl:value-of select="."/></xsl:for-each>**&#009;**<xsl:for-each
                select=".//dc:title"><xsl:value-of select="."/></xsl:for-each>**&#009;**<xsl:for-each
                    select=".//dc:date.created"><xsl:value-of select="."/></xsl:for-each>**&#009;<xsl:choose>
                <xsl:when test=".//dc:creator[not(position() = last())]">**<xsl:for-each
                        select=".//dc:creator[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//dc:creator[position() = last()]"/>**&#009;</xsl:when>
                    <xsl:otherwise>**<xsl:value-of select=".//dc:creator"/>**&#009;</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//dc:description[contains(text(),'Abstract:')]">**<xsl:for-each
                    select=".//dc:description[contains(text(),'Abstract:')]"><xsl:value-of
                            select="substring-before(.,'Abstract:')"/></xsl:for-each>**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dc:description"
                />**&#009;</xsl:otherwise>
            </xsl:choose>
        <xsl:choose>
            <xsl:when test=".//dc:description[contains(text(),'Abstract:')]">**<xsl:for-each
                select=".//dc:description[contains(text(),'Abstract:')]"><xsl:value-of
                    select="substring-after(.,'Abstract:')"/></xsl:for-each>**&#009;</xsl:when>
            <xsl:otherwise>** **&#009;</xsl:otherwise>
        </xsl:choose>
            <xsl:choose>
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
                <xsl:when test=".//dcadesc:subject[not(position() = last())]">**<xsl:for-each
                        select=".//dcadesc:subject[not(position() = last())]"><xsl:value-of
                            select="replace(., '(\w$|\W$)', '$1|')"/></xsl:for-each><xsl:value-of
                                select=".//dcadesc:subject[position() = last()]"/>**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of select=".//dcadesc:subject"
                />**&#009;</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept'][not(position() = last())]"
                        >**<xsl:for-each
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept'][not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept'][position() = last()]"
                        />**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'creatordept']"
                />**&#009;</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo'][not(position() = last())]"
                        >**<xsl:for-each
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo'][not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo'][position() = last()]"
                        />**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/admin/*[namespace-uri() = 'http://nils.lib.tufts.edu/dcaadmin/' and local-name() = 'embargo']"
                />**&#009;</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource[not(position() = last())]"
                        >**<xsl:for-each
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource[not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource[position() = last()]"
                        />**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'hasDescription']/@rdf:resource"
                />**&#009;</xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when
                    test="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource[not(position() = last())]"
                        >**<xsl:for-each
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource[not(position() = last())]"
                            ><xsl:value-of select="replace(., '(\w$|\W$)', '$1|')"
                        /></xsl:for-each><xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource[position() = last()]"
                        />**&#009;</xsl:when>
                <xsl:otherwise>**<xsl:value-of
                        select="*/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'RDF']/*[namespace-uri() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' and local-name() = 'Description']/*[namespace-uri() = 'info:fedora/fedora-system:def/relations-external#' and local-name() = 'isMemberOf']/@rdf:resource"
                    />**&#xD;</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
