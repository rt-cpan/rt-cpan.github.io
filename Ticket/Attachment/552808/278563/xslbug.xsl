<!-- xslbug.xml:

<?xml version="1.0"?>
<DUMMY>
</DUMMY>

-->

<!-- xslbug.xsl: -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

<!-- stylesheet outputs

<?xml version="1.0"?>

  how can this be correct behavior with the 'method = text ??

-->

  <xsl:template match="/" >

<!-- desired output = '"testid: <hello>goodbye"' -->

SOD&quot;simple-text: &lt;hello&gt;goodbye&quot;EOD

<!-- simple-6ext ouputs

SOD"simple-text: &lt;hello&gt;goodbye"EOD

  notice &quot is translated, while the &lt;,$gt; are not

  there should be no output escaping as indicated by youyr reference

  (it's this failure that led me to try a CDATA section)

-->

SOD<![CDATA["cdata-section: <hello>goodbye"]]>EOD

<!-- cdata-section outputs

SOD"cdata-section: &lt;hello&gt;goodbye"EOD

  notice < and > in the CDATA section are escaped. while the quotes are passed through.

  how can this be correct behavior

  (this failure led me to try d-o-e)

-->

SOD<xsl:text disable-output-escaping="yes">&quot;d-o-e-text-element: &lt;hello&gt;goodbye&quot;</xsl:text>EOD

<!-- d-o-e outputs

SOD
"d-o-e-text-element: <hello>goodbye"
EOD

  so this is the behavior I expected without d-o-e enabled  except I get newlines
  before and after the text element: which makes it totally useless as a workaround.

-->

  </xsl:template>
</xsl:stylesheet>

<!-- this is the complete unedited output

C:\myTk\dd>xr apply xslbug xslbug
<?xml version="1.0"?>


SOD"simple-text: &lt;hello&gt;goodbye"EOD



SOD"cdata-section: &lt;hello&gt;goodbye"EOD



SOD
"d-o-e-text-element: <hello>goodbye"
EOD


C:\myTk\dd>

-->

