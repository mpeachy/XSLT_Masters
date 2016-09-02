<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd"
    version="2.0">
    <!-- Updates -->
    <xsl:output method="text" encoding="UTF-8" />
    <xsl:variable name="rbbin">
        <xsl:for-each
            select="//marc:datafield[@tag='655']/marc:subfield[@code='2'][contains(.,'rbbin')] ">
            <xsl:sort select="parent::marc:datafield[@tag='655']"/>
            <xsl:for-each
                select="parent::marc:datafield[@tag='655'][not(.=following::marc:datafield[@tag='655'])]">
                <xsl:value-of select="./replace(.,'rbbin|MMeT', ' ')"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="rbprov">
        <xsl:for-each
            select="//marc:datafield[@tag='655']/marc:subfield[@code='2'][contains(.,'rbprov')] ">
            <xsl:sort select="parent::marc:datafield[@tag='655']"/>
            <xsl:for-each
                select="parent::marc:datafield[@tag='655'][not(.=following::marc:datafield[@tag='655'])]">
                <xsl:value-of select="./replace(.,'rbprov|MMeT', ' ')"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="rbpri">
        <xsl:for-each
            select="//marc:datafield[@tag='655']/marc:subfield[@code='2'][contains(.,'rbpri')] ">
            <xsl:sort select="parent::marc:datafield[@tag='655']"/>
            <xsl:for-each
                select="parent::marc:datafield[@tag='655'][not(.=following::marc:datafield[@tag='655'])]">
                <xsl:value-of select="./replace(.,'rbpri|MMeT', ' ')"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="rbgen">
        <xsl:for-each
            select="//marc:datafield[@tag='655']/marc:subfield[@code='2'][contains(.,'rbgen')] ">
            <xsl:sort select="parent::marc:datafield[@tag='655']"/>
            <xsl:for-each
                select="parent::marc:datafield[@tag='655'][not(.=following::marc:datafield[@tag='655'])]">
                <xsl:value-of select="./replace(.,'rbgenr|MMeT', ' ')"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="rbpap">
        <xsl:for-each
            select="//marc:datafield[@tag='655']/marc:subfield[@code='2'][contains(.,'rbpap')] ">
            <xsl:sort select="parent::marc:datafield[@tag='655']"/>
            <xsl:for-each
                select="parent::marc:datafield[@tag='655'][not(.=following::marc:datafield[@tag='655'])]">
                <xsl:value-of select="./replace(.,'rbpap|MMeT', ' ')"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>
    <xsl:template match="/"> 
Tisch Library Special Collections: A short-title catalog of RBMS terms recently used.
  
  
Binding Terms

        <xsl:value-of select="$rbbin"/> 
        
Provenance Terms 
        
        <xsl:value-of select="$rbprov"/> 
        
Printing Terms 
        
        <xsl:value-of select="$rbpri"/> 
        
Genre Terms
            
        <xsl:value-of select="$rbgen"/> 
        
Paper Terms 
        
        <xsl:value-of select="$rbpap"/>
    
    </xsl:template>
</xsl:stylesheet>
