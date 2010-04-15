<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes" version="2.0" exclude-result-prefixes="xhtml xsl fn xs xdt">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" indent="yes" />
    <!-- the identity template -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xhtml:div [@class = 'reqset']">
        <div class="reqset">
            <xsl:attribute name="id">
                <xsl:value-of select="@id" />
            </xsl:attribute>
            <xsl:call-template name="editlink">
                <!-- FIXME Get rid of this horrible abortion of an xpath query -->
                <xsl:with-param name="section" select="xhtml:div/xhtml:*/xhtml:span [@class='path']/text()" />
                <xsl:with-param name="root" select="//xhtml:div [ @class='root']/text()" />
            </xsl:call-template>
           
            <xsl:apply-templates />
        </div>
    </xsl:template>
    <xsl:template name="editlink">
        <xsl:param name="section" select="." />
        <xsl:param name="root" select="." />
    <a class="editlink">
        <xsl:attribute name="href"><xsl:value-of select="$root" />/section/<xsl:value-of select="$section" />/edit</xsl:attribute>
        Edit
    </a>
    </xsl:template>
</xsl:stylesheet>
