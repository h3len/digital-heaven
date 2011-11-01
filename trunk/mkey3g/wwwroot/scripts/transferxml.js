/*------------------------------------------------
 * Javascript Xslt解析Xml
 * 兼容IE & FireFox等浏览器
 * By yesun 修改于2006-3-23
 * http://edzh.com
 *------------------------------------------------*/

function DisplayTransformedXML(Number, XmlDocumentInput, XSLFile,DivOutput)
{
    BrowserName = navigator.appName;
    Version = navigator.appVersion;
    if (BrowserName == "Netscape")
    {
	//FireFox
        var XMLHTTPRequest;
        var XSLStyleSheet;
        var XSLProcessor;
        var XMLSource;

        if(typeof(XmlDocumentInput) == "object")
        { //如果传入的就是xml dom
          XMLSource = XmlDocumentInput;
        }
        else
        {
          XMLSource = (new DOMParser()).parseFromString(XmlDocumentInput,"text/xml");
        }

        // Load the XSL style sheet
        XMLHTTPRequest = new XMLHttpRequest();
        XMLHTTPRequest.open("GET", XSLFile, false);
        XMLHTTPRequest.send(null);
        XSLStyleSheet = XMLHTTPRequest.responseXML;

        // Instantiate the XSLT processor and associate a XSL style sheet with it
        XSLProcessor= new XSLTProcessor();
        XSLProcessor.importStylesheet(XSLStyleSheet);

        /* Code needed to debug some XML object in Mozilla */
        // var Serializer= new XMLSerializer();
        // window.alert( Serializer.serializeToString( xslStylesheet ) );
        /* End code needed to debug some XML object in Mozilla */


        // Set an optional parameter to the style sheet
        XSLProcessor.setParameter(null, "selected_packet", Number);

        // Transform the XML source according to the appropriate style sheet
        //alert(XmlDocumentInput);
        if(XMLSource == null)
        {
			alert("XML数据源错误");
        }
        var XMLDOMFragment = XSLProcessor.transformToFragment(XMLSource, document);

        //Print the result of the transformation into the appropriate element into the HTML page 
        DivOutput.innerHTML = "";
        DivOutput.appendChild(XMLDOMFragment);
          
    }
    else if (BrowserName == "Microsoft Internet Explorer")
    {
		//Win2003,IE
        var XSLStyleSheet;
        var XMLSource;
        var XSLTemplate;
        var XSLProcessor;

        // Load the XML source file
        XMLSource = new ActiveXObject("Msxml2.DOMDocument");
        XMLSource.async = false;
        XMLSource.resolveExternals = false;
        //判断数据源是String还是Xml Dom
        if(typeof(XmlDocumentInput) == "object")
        {//xml dom
			XMLSource.load(XmlDocumentInput);
        }
        else
        {//string
        	XMLSource.loadXML(XmlDocumentInput);
        }

        // Load the XSL style sheet
        var XSLStyleSheet= new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
        // We cannot use the following lines, because templates must be created as 'FreeThreadedDOMDocument'
        // In case we do not want to set parameters to the style sheet, we can use the code below and skip the rest
        // XSLStyleSheet= document.getElementById("IDStyleSheet");
        // XSLStyleSheet.async = false;
        // XSLStyleSheet.resolveExternals = false;
        // IDOutputHTML.innerHTML= source.transformNode(XSLStyleSheet);                // This line works only in IE; the next one is equivalent and it works also in Mozilla
        // document.getElementById("IDOutputHTML").innerHTML= XMLSource.transformNode(XSLStyleSheet);

        XSLStyleSheet.async = false;
        //Load Xslt ^_^
        XSLStyleSheet.load(XSLFile);
        XSLStyleSheet.resolveExternals = false;

        // Instantiate the XSLT processor and associate a XSL style sheet with it
        XSLTemplate= new ActiveXObject("Msxml2.XSLTemplate");
        XSLTemplate.stylesheet= XSLStyleSheet;
        XSLProcessor= XSLTemplate.createProcessor();
        XSLProcessor.input = XMLSource;

        // Set an optional parameter to the style sheet
        XSLProcessor.addParameter("selected_packet", Number);


        // Transform the XML source according to the appropriate style sheet
        XSLProcessor.transform();

        // Print the result of the transformation into the appropriate element into the HTML page
        DivOutput.innerHTML= XSLProcessor.output;
    }
}
