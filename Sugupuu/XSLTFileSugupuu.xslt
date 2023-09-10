<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				>
	<xsl:output method="xml" indent="yes" encoding="utf-8"/>

	<xsl:template match="/">

		<strong>1. Trüki välja sugupuu kõikide inimeste nimed ja sünniaastad</strong>
		<ul>
			<xsl:for-each select="//inimene">
				<xsl:sort select="@synd"/>
				<li>
					<xsl:value-of select="concat(nimi, ' (', @synd, ')', ' - ', @sugu)" />,
				</li>
			</xsl:for-each>
		</ul>
		<br/>
		<strong>2. Väljasta nimed, kellel on vähemalt 2 last</strong>
		<ul>
			<xsl:for-each select="//inimene[lapsed]">
				<xsl:sort select="@synd"/>
				<xsl:if test="count(lapsed/inimene)&gt;= 2">
					<li>
						<xsl:value-of select="concat(nimi, ' (', @synd, ')', ' - ', @sugu, '. Kokku last: ', count(lapsed/inimene))" />,
					</li>
				</xsl:if>
			</xsl:for-each>
		</ul>
		<br/>
		<strong>3. Väljasta saadud andmed tabelina</strong>
		<strong>5. Värvida tabelis kõik nimed pikkusega vähem kui 10 tähte rohelise taustavärviga </strong>

		<div>
			<table border="2pt solid black">
				<thead>
					<tr>
						<th>Nimi</th>
						<th>Vanem</th>
						<th>Synniaasta</th>
						<th>Vanus</th>
						<th>Sugu</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="//inimene">
						<xsl:sort select="@synd"/>
						<tr>

							<xsl:choose>
								<xsl:when test="string-length(nimi) &lt; 10">
									<td bgcolor="#009879">
										<xsl:value-of select="nimi"/>
									</td>
								</xsl:when>
								<xsl:when test="string-length(nimi) &lt; 13">
									<td bgcolor="red">
										<xsl:value-of select="nimi"/>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td>
										<xsl:value-of select="nimi"/>
									</td>
								</xsl:otherwise>
							</xsl:choose>

							<td>
								<xsl:value-of select="../../nimi"/>
							</td>
							<td>
								<xsl:value-of select="@synd"/>
							</td>
							<td>
								<xsl:value-of select="2023 - @synd"/>
							</td>
							<td>
								<xsl:value-of select="@sugu"/>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</div>
		<br/>

		<strong>4. Väljasta iga inimese juures mitmendal oma vanema sünniaastal ta sündis </strong>
		<ul>
			<xsl:for-each select="//inimene">
				<xsl:sort select="@synd"/>
				<li>
					<xsl:value-of select="nimi"/>
					<xsl:if test="../..">
						- lapsevanema vanus oli
						<xsl:value-of select="@synd - ../../@synd"/>
						aastat vana
					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>
		<br/>



		<style> table { border: 4pt solid black; border-collapse: collapse; font-size: 16pt; } tr:nth-child(even) { background-color: lightgray; } </style>

	</xsl:template>
</xsl:stylesheet>
