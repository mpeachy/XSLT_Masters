<!--    
CREATED BY: Alex May, Tisch Library, based on the XSLT Title Case Converter by griffmonster
CREATED ON: 2014-07-07
UPDATED ON: 2014-07-30
This stylesheet creates a function for normalizing data entry errors in the title field, which is called in the ThesesBatch xslt -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:alex="http:alex.edu">
    <!-- this portion of the XSLT creates the parameters that will call the seperate titleCaseExceptions xml document-->
    <xsl:param name="strExceptionsFilename">titleCaseExceptions.xml</xsl:param>
    <xsl:param name="nstExceptions" select="document($strExceptionsFilename)"/>
    <!-- this portion of the XSLT creates the named function-->
    <xsl:function name="alex:fnTitleCase">
        <xsl:param name="string"/>
        <xsl:variable name="intLength" select="string-length($string)"/>
        <xsl:variable name="tokenizedSample" select="tokenize($string,'\s')"/>
        <xsl:for-each select="$tokenizedSample">
            <xsl:variable name="strToken" select="."/>
            <!-- this portion of the XSLT tests if an exception term starts the title, if it does it converts it to capital case-->
            <xsl:choose>
                <xsl:when
                    test="position()=1 and $nstExceptions//Exception[lower-case(self::*) = lower-case($strToken)]">
                    <xsl:value-of select="upper-case(substring($strToken,1,1))"/>
                    <xsl:value-of select="lower-case(substring($strToken, 2, $intLength))"/>
                </xsl:when>
                <!-- this portion of the XSLT inserts matching exceptions-->
                <xsl:when
                    test="$nstExceptions//Exception[lower-case(self::*) = lower-case($strToken)]">
                    <xsl:value-of
                        select="$nstExceptions//Exception[lower-case(self::*) = lower-case($strToken)]"
                    />
                </xsl:when>
                <!--Filter for quotes -->
                <xsl:when test="starts-with(lower-case($strToken),'&quot;')">&quot;<xsl:value-of
                        select="upper-case(substring($strToken, 2, 1))"/><xsl:value-of
                        select="lower-case(substring($strToken, 3, $intLength))"/>
                </xsl:when>
                <!--Filter for brackets -->
                <xsl:when test="starts-with(lower-case($strToken),'[')">[<xsl:value-of
                        select="upper-case(substring($strToken, 2, 1))"/><xsl:value-of
                        select="lower-case(substring($strToken, 3, $intLength))"/>
                </xsl:when>          
                <!--Filter for parrens -->
                <xsl:when test="starts-with(lower-case($strToken),'(')">(<xsl:value-of
                        select="upper-case(substring($strToken, 2, 1))"/><xsl:value-of
                        select="lower-case(substring($strToken, 3, $intLength))"/>
                </xsl:when>
                <!--filter for full-stops, that is, acronyms-->
                <xsl:when test="contains(lower-case($strToken),'.')">
                    <xsl:variable name="tokenizedStop" select="tokenize($strToken,'\.')"/>
                    <xsl:for-each select="$tokenizedStop">
                        <xsl:value-of select="upper-case(substring(., 1, 1))"/>
                        <xsl:value-of select="lower-case(substring(., 2))"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>.</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <!--filter for hyphenated terms-->
                <xsl:when test="contains(lower-case($strToken),'-')">
                    <xsl:variable name="tokenizedHyphen" select="tokenize($strToken,'-')"/>
                    <xsl:for-each select="$tokenizedHyphen">
                        <xsl:value-of select="upper-case(substring(., 1, 1))"/>
                        <xsl:value-of select="lower-case(substring(., 2))"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>-</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <!--filter for forward-slash terms-->
                <xsl:when test="contains(lower-case($strToken),'/')">
                    <xsl:variable name="tokenizedForwardSlash" select="tokenize($strToken,'/')"/>
                    <xsl:for-each select="$tokenizedForwardSlash">
                        <xsl:value-of select="upper-case(substring(., 1, 1))"/>
                        <xsl:value-of select="lower-case(substring(., 2))"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>/</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <!--filter for back-slash terms-->
                <xsl:when test="contains(lower-case($strToken),'\')">
                    <xsl:variable name="tokenizedBackSlash" select="tokenize($strToken,'\')"/>
                    <xsl:for-each select="$tokenizedBackSlash">
                        <xsl:value-of select="upper-case(substring(., 1, 1))"/>
                        <xsl:value-of select="lower-case(substring(., 2))"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>\</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <!--filter for single quotes and apostrophe s -->
                <xsl:when test="contains(lower-case($strToken),'''')[not(ends-with($strToken,'''s'))]">
                    <xsl:variable name="tokenizedApos" select="tokenize($strToken,'''')"/>
                    <xsl:for-each select="$tokenizedApos">
                        <xsl:value-of select="upper-case(substring(., 1, 1))"/>
                        <xsl:value-of select="lower-case(substring(., 2))"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>'</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <!--normalize semi-colon's-->
                <xsl:when test="contains(lower-case($strToken),';')">
                    <xsl:variable name="tokenizedSemi" select="tokenize($strToken,';')"/>
                    <xsl:for-each select="$tokenizedSemi">
                        <xsl:value-of select="upper-case(substring(., 1, 1))"/>
                        <xsl:value-of select="lower-case(substring(., 2))"/>
                        <xsl:if test="position() != last()">
                            <xsl:text>; </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="upper-case(substring($strToken, 1, 1))"/>
                    <xsl:value-of select="lower-case(substring($strToken, 2, $intLength))"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Puts spacing back in -->
            <xsl:choose>
                <xsl:when
                    test="position() != last() and matches($strToken,'[A-Z][A-Z]?[0-9][0-9]?')">
                    <xsl:text>&#160;</xsl:text>
                </xsl:when>
                <xsl:when test="position() != last()">
                    <xsl:text> </xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
</xsl:stylesheet>
