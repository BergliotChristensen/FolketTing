<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="no"/>
    
    <!-- Root template -->
    <xsl:template match="/">
        <xsl:text>FOLKETING PROCEEDINGS&#10;</xsl:text>
        <xsl:text>====================&#10;&#10;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Agenda template -->
    <xsl:template match="DagsordenPlan">
        <xsl:text>AGENDA&#10;</xsl:text>
        <xsl:text>------&#10;</xsl:text>
        <xsl:apply-templates select="PunktTekst"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <!-- Agenda item template -->
    <xsl:template match="DagsordenPunkt">
        <xsl:text>Item </xsl:text>
        <xsl:value-of select="MetaFTAgendaItem/@number"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="PunktTekst"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="Aktivitet"/>
    </xsl:template>
    
    <!-- Sub-item template -->
    <xsl:template match="DagsordenUnderpunkt">
        <xsl:text>    Sub-item </xsl:text>
        <xsl:value-of select="MetaFTAgendaSubItem/@number"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="PunktTekst"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="Tale"/>
    </xsl:template>
    
    <!-- Speech template -->
    <xsl:template match="Tale">
        <xsl:text>&#10;SPEECH&#10;</xsl:text>
        <xsl:text>Speaker: </xsl:text>
        <xsl:apply-templates select="Taler"/>
        <xsl:if test="TaleType">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="TaleType"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="TaleSegment"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <!-- Speaker template -->
    <xsl:template match="Taler">
        <xsl:value-of select="MetaSpeakerMP/@name"/>
        <xsl:if test="TalerTitel">
            <xsl:text>, </xsl:text>
            <xsl:value-of select="TalerTitel"/>
        </xsl:if>
    </xsl:template>
    
    <!-- Speech segment template -->
    <xsl:template match="TaleSegment">
        <xsl:text>-------------------&#10;</xsl:text>
        <xsl:apply-templates select="TekstGruppe"/>
        <xsl:apply-templates select="Exitus"/>
        <xsl:apply-templates select="SagAnmeldelse"/>
    </xsl:template>
    
    <!-- Text group template -->
    <xsl:template match="TekstGruppe">
        <xsl:apply-templates select="Exitus"/>
        <xsl:apply-templates select="TekstGruppe"/>
    </xsl:template>
    
    <!-- Text content template -->
    <xsl:template match="Exitus">
        <xsl:value-of select="."/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <!-- Case notice template -->
    <xsl:template match="SagAnmeldelse">
        <xsl:text>NOTICE: </xsl:text>
        <xsl:apply-templates select="Exitus"/>
    </xsl:template>
    
    <!-- Table handling -->
    <xsl:template match="Table">
        <xsl:text>&#10;TABLE:&#10;</xsl:text>
        <xsl:apply-templates select="Tr"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="Tr">
        <xsl:apply-templates select="Th|Td"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="Th|Td">
        <xsl:text>| </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text> </xsl:text>
    </xsl:template>
</xsl:stylesheet>