<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>
	<xsl:key name="elukohad" match="inimene" use="@elukoht"/>
	<xsl:template match="/">
		1. Trüki välja vanaema nimi, pärast semikoolon ja tema lapsed
		<br/>
		<xsl:variable name="vanaema" select="//inimene[nimi='Valentina']"/>
		<xsl:value-of select="$vanaema/nimi"/>
		<xsl:text>: </xsl:text>
		<xsl:apply-templates select="$vanaema/lapsed"/>
		<br/>
		2. Vormista kõik xml andmed tabelina / 	5. Leia iga inimesele mitu last temal on / 6. Värvi tabelis kõik nimed mis sisaldavad M täht punasena (M asemel pane oma täht (K))
		/ 7. Värvi kõik nimed, kellel on vähemalt kaks last kollasena (taustavärv on kollane) / 8. Oma ülesanne: Kirjutage, kui vana inimene hetkel on


		<html>
			<body>
				<table>
					<tr>
						<th>Nimi</th>
						<th>Perekonnanimi</th>
						<th>Sünniaasta</th>
						<th>Elukoht</th>
						<th>Sugu</th>
						<th>Laste arv</th>
						<th>Vanus</th>
					</tr>
					<xsl:apply-templates select="//inimene"/>
				</table>
			</body>
			<style>
				table {
					border-collapse: collapse;
					width: 100%;
				}
				th, td {
					border: 1px solid black;
					padding: 8px;
					text-align: left;
				}
				th {
					background-color: #f2f2f2;
				}
			</style>
		</html>
		<br/>
		4. Arvuta mitu inimest elavad igas elukohas
		<br/>
		<xsl:for-each select="//inimene[generate-id() = generate-id(key('elukohad', @elukoht)[1])]">
			<xsl:variable name="elukoht" select="@elukoht"/>
			<xsl:value-of select="$elukoht"/>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="count(key('elukohad', $elukoht))"/>
			<xsl:text> inimest</xsl:text>
			<xsl:text>&#10;</xsl:text>
		</xsl:for-each>
		<br/>
		
	</xsl:template>
	
	

	<xsl:template match="lapsed">
		<xsl:for-each select="inimene">
			<xsl:value-of select="nimi"/>
			<xsl:if test="position() &lt; last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="inimene">
		<xsl:variable name="childCount" select="count(lapsed/inimene)"/>
		<xsl:variable name="containsM" select="contains(nimi, 'M')"/>
		<xsl:variable name="modifiedName">
			<xsl:choose>
				<xsl:when test="$containsM">
					<xsl:value-of select="translate(nimi, 'M', 'K')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="nimi"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr>
			<xsl:if test="$childCount >= 2">
				<xsl:attribute name="style">background-color: yellow;</xsl:attribute>
			</xsl:if>
			<td>
				<xsl:if test="$containsM">
					<font color="red">
						<xsl:value-of select="$modifiedName"/>
					</font>
				</xsl:if>
				<xsl:if test="not($containsM)">
					<xsl:value-of select="$modifiedName"/>
				</xsl:if>
			</td>
			<td>
				<xsl:value-of select="perekonnanimi"/>
			</td>
			<td>
				<xsl:value-of select="@synd"/>
			</td>
			<td>
				<xsl:value-of select="@elukoht"/>
			</td>
			<td>
				<xsl:value-of select="@sugu"/>
			</td>
			<td>
				<xsl:value-of select="$childCount"/>
			</td>
			<td>
				<xsl:variable name="currentYear" select="2023" />
				<xsl:variable name="birthYear" select="@synd" />
				<xsl:variable name="age" select="$currentYear - $birthYear" />
				<xsl:value-of select="concat('Vanus: ', $age)" />
			</td>
		</tr>
	</xsl:template>



</xsl:stylesheet>
