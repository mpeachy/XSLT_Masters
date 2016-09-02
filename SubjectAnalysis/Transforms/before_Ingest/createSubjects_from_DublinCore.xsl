<?xml version="1.0" encoding="UTF-8"?>
<!-- Vi.*y\) finds Vicenza (Italy) -->
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
        xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
        xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xlink="http://www.w3.org/1999/xlink"
        >
        <!-- Output as a text file -->
        <xsl:output method="text" encoding="UTF-16"/>
        <!-- Create variables, output subjects, sort alphabeticaly, remove duplicates -->
        <xsl:variable name="creatorname">
            <xsl:for-each select="//dc:creator">
                <xsl:sort select="self::dc:creator"/>
                <xsl:for-each select="self::dc:creator[not(.=following::dc:creator)]">
                    <xsl:value-of select="replace(.,'(\w$|\W$)','$1&#xD;')"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="contribname">
            <xsl:for-each select="//dcterms:contributor"> 
                <xsl:sort select="self::dcterms:contributor"/>
                <xsl:for-each select="self::dcterms:contributor[not(.=following::dcterms:contributor)]">
                    <xsl:value-of select="replace(.,'(\w$|\W$)','$1&#xD;')"/>  
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="persname">
            <xsl:for-each select="//dcadesc:persname">
                <xsl:sort select="self::dcadesc:persname"/>
                <xsl:for-each select="self::dcadesc:persname[not(.=following::dcadesc:persname)]">
                    <xsl:value-of select="replace(.,'(\w$|\W$)','$1&#xD;')"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="corpname">
            <xsl:for-each select="//dcadesc:corpname">
                <xsl:sort select="self::dcadesc:corpname"/>
                <xsl:for-each select="self::dcadesc:corpname[not(.=following::dcadesc:corpname)]">
                    <xsl:value-of select="replace(.,'(\w$|\W$)','$1&#xD;')"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="geogname">
            <xsl:for-each select="//dcadesc:geogname">
                <xsl:sort select="self::dcadesc:geogname"/>
                <xsl:for-each select="self::dcadesc:geogname[not(.=following::dcadesc:geogname)]">
                    <xsl:value-of select="replace(.,'(\w$|\W$)','$1&#xD;')"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="subject">
            <xsl:for-each select="//dcadesc:subject">
                <xsl:sort select="self::dcadesc:subject"/>
                <xsl:for-each select="self::dcadesc:subject[not(.=following::dcadesc:subject)]">
                    <xsl:value-of select="replace(.,'(\w$|\W$)','$1&#xD;')"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="genre">
            <xsl:for-each select="//dcadesc:genre">
                <xsl:sort select="self::dcadesc:genre"/>
                <xsl:for-each select="self::dcadesc:genre[not(.=following::dcadesc:genre)]">
                    <xsl:value-of select="replace(.,'(\w$|\W$)','$1&#xD;')"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:template match="/">             
Terms recently used
            
Names:
            Creators
            
<xsl:value-of select="$creatorname"/>
            
            Contributors

<xsl:value-of select="$contribname"/>
            
            Personal names as subject
            
<xsl:value-of select="$persname"/>
            
            
Subjects:

            Corporate Terms 
            
<xsl:value-of select="$corpname"/>
            
            Geographic Terms 

<xsl:value-of select="$geogname"/> 
            
            LCSH 

<xsl:value-of select="$subject"/>
            
            Genre Terms 
            
<xsl:value-of select="$genre"/>
        </xsl:template>
    </xsl:stylesheet>
    
