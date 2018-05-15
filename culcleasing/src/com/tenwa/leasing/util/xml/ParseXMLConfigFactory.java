package com.tenwa.leasing.util.xml;

import java.util.Hashtable;
import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class ParseXMLConfigFactory {

	private static DocumentBuilderFactory domfac;

	public String configFile = "config.xml";

	static {
		domfac = DocumentBuilderFactory.newInstance();
	}

	public String getConfigFile() {
		return configFile;
	}

	public void setConfigFile(String configFile) {
		this.configFile = configFile;
	}

	public ParseXMLConfigFactory() {

	}

	@SuppressWarnings("unchecked")
	public Hashtable getConfiguration() throws Exception {
		DocumentBuilder dombuilder = null;
		Document doc = null;
		Element root = null;
		NodeList config = null;
		Hashtable htRet = new Hashtable();
		ParseXMLConfigFactory parse = new ParseXMLConfigFactory();
		try {
			dombuilder = domfac.newDocumentBuilder();
			doc = dombuilder.parse(ResourceLocator.getResourceURL(configFile)
					.openStream());
			root = doc.getDocumentElement();
			config = root.getChildNodes();
			Hashtable htParam = parse.getConfigParam(config);
			Vector vKey = (Vector) htParam.get("key");
			Vector vPath = (Vector) htParam.get("xml");
			for (int i = 0; i < vKey.size(); i++) {
				htRet.put(vKey.get(i), parse.getNodeText(config, String
						.valueOf(vPath.get(i))));
			}
		} catch (Exception e) {

		}
		return htRet;
	}

	private String getNodeText(NodeList nodes, String nodePath) {
		String text = "";
		String path = "";
		String otherPath = "";
		int ileng = nodePath.indexOf("\\");
		if (ileng != -1) {
			path = nodePath.substring(0, ileng);
			otherPath = nodePath.substring(ileng + 2, nodePath.length());
		} else {
			path = nodePath;
		}
		for (int i = 1; i < nodes.getLength(); i += 2) {
			Node item = nodes.item(i);
			if (item.hasChildNodes()) {
				if (item.getNodeName() != null
						&& item.getNodeName().equals(path)) {
					if (otherPath != null && !otherPath.equals("")) {
						text += getNodeText(item.getChildNodes(), otherPath);
					} else {
						if (item.hasChildNodes()) {
							NodeList child = item.getChildNodes();
							if (child.getLength() > 1) {
								for (int j = 0; j < child.getLength(); j++) {
									text += child.item(0).getNodeValue() + ";";
								}
							} else {
								text += child.item(0).getNodeValue();
							}
							break;
						}
					}
				}
			}
		}

		return text;
	}

	@SuppressWarnings("unchecked")
	public Hashtable getConfigParam(NodeList config) {
		Hashtable htParam = new Hashtable();
		Vector vKey = new Vector();
		Vector vPath = new Vector();
		Node parameters = config.item(1);
		NodeList nlParam = parameters.getChildNodes();
		for (int i = 1; i < nlParam.getLength(); i += 2) {
			Node parameter = nlParam.item(i);
			NamedNodeMap nnm = parameter.getAttributes();
			vKey.add(nnm.getNamedItem("name").getNodeValue());
			vPath.add(nnm.getNamedItem("value").getNodeValue());
		}
		htParam.put("key", vKey);
		htParam.put("xml", vPath);
		return htParam;
	}

}
