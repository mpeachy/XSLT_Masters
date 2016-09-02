<?xml version="1.0" encoding="UTF-8"?>

<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2014-07-07
UPDATED ON: 2014-07-28
This stylesheet creates a group of templates for normalizing data entry errors, which are called in the ThesesBatch xslt -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/" xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/">
    
    <!-- this portion declares the template and its param name -->
    <xsl:template name="creatorDept">
        <xsl:param name="Dept"/>
    <!-- this portion inserts the admin:creatordept element depending on the following text in a topicTerm -->
    <xsl:choose>
        <xsl:when test="topicTerms [contains(text(),'Department of History')]">
            <admin:creatordept>UA005.001</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Philosophy')]">
            <admin:creatordept>UA005.002</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Economics')]">
            <admin:creatordept>UA005.003</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'International Relations')]">
            <admin:creatordept>UA005.004</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of English')]">
            <admin:creatordept>UA005.005</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Psychology')]">
            <admin:creatordept>UA005.006</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Political Science')]">
            <admin:creatordept>UA005.007</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'American Studies')]">
            <admin:creatordept>UA005.008</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Child Developement')]">
            <admin:creatordept>UA005.009</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Biology')]">
            <admin:creatordept>UA005.010</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Sociology')]">
            <admin:creatordept>UA005.011</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Chemical and Biological Engineering')]">
            <admin:creatordept>UA005.012</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Art and Art History')]">
            <admin:creatordept>UA005.013</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of German, Russian and Asian Languages')]">
            <admin:creatordept>UA005.014</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Chemistry')]">
            <admin:creatordept>UA005.015</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Plan of Study')]">
            <admin:creatordept>UA005.016</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Program in Asian Studies')]">
            <admin:creatordept>UA005.017</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Africa and the New World')]">
            <admin:creatordept>UA005.018</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Biomedical Engineering')]">
            <admin:creatordept>UA005.019</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Romance Languages')]">
            <admin:creatordept>UA005.020</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Unspecified')]">
            <admin:creatordept>UA005.021</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Physics and Astronomy')]">
            <admin:creatordept>UA005.022</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Program in Judaic Studies')]">
            <admin:creatordept>UA005.023</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Religion')]">
            <admin:creatordept>UA005.024</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Classics')]">
            <admin:creatordept>UA005.025</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Drama and Dance')]">
            <admin:creatordept>UA005.026</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Program in Women Studies')]">
            <admin:creatordept>UA005.027</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Mechanical Engineering')]">
            <admin:creatordept>UA005.028</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Program in Engineering Psychology')]">
            <admin:creatordept>UA005.029</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Program in Archaeology')]">
            <admin:creatordept>UA005.030</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Program in Community Health')]">
            <admin:creatordept>UA005.031</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Mathematics')]">
            <admin:creatordept>UA005.032</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Program in International Literary and Visual Studies.')]">
            <admin:creatordept>UA005.033</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Music')]">
            <admin:creatordept>UA005.034</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Electrical Engineering and Computer Science.')]">
            <admin:creatordept>UA005.035</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Computer Science')]">
            <admin:creatordept>UA005.036</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Biopsychology (interdisciplinary major)')]">
            <admin:creatordept>UA005.037</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'Department of Earth and Ocean Sciences')]">
            <admin:creatordept>UA005.038</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Peace and Justice Studies Program')]">
            <admin:creatordept>UA005.039</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Civil and Environmental Engineering')]">
            <admin:creatordept>UA005.040</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Program in Middle Eastern Studies')]">
            <admin:creatordept>UA005.041</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Latin American Studies')]">
            <admin:creatordept>UA005.042</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Center for Interdisciplinary Studies')]">
            <admin:creatordept>UA005.043</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'MALD thesis')]">
            <admin:creatordept>UA015.012</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'MIB thesis')]">
            <admin:creatordept>UA015.012</admin:creatordept>
        </xsl:when>
        <xsl:when test="topicTerms [contains(text(),'LLM thesis')]">
            <admin:creatordept>UA015.012</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Tisch Library Undergraduate Research Award')]">
            <admin:creatordept>UA137.008</admin:creatordept>
        </xsl:when>
        <xsl:when
            test="topicTerms [contains(text(),'Department of Education records')]">
            <admin:creatordept>UA071.001</admin:creatordept>
        </xsl:when>
        <xsl:when test="corporateNames [contains(text(),'Perseus')]">
            <admin:creatordept>PB.001</admin:creatordept>
        </xsl:when>
        <xsl:otherwise>
            <admin:creatordept>PB.002</admin:creatordept>
        </xsl:otherwise>
    </xsl:choose>
    </xsl:template>
</xsl:stylesheet>

<!-- insert this into ThesesBatch_RunThis if creatorDept_helper is needed

<xsl:call-template name="creatorDept">
    <xsl:with-param name="Dept">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:with-param>

</xsl:call-template> --> 