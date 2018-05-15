/**
 * IService4BillLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.webService.service;

public class IService4BillLocator extends org.apache.axis.client.Service implements com.webService.service.IService4Bill {

    public IService4BillLocator() {
    }


    public IService4BillLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public IService4BillLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for IService4BillSOAP11port_http
   // private java.lang.String IService4BillSOAP11port_http_address = "http://10.122.2.54:9011/uapws/service/nc.ws.webservice.IService4Bill";
    private java.lang.String IService4BillSOAP11port_http_address = "http://10.122.2.80:88/uapws/service/nc.ws.webservice.IService4Bill";

    public java.lang.String getIService4BillSOAP11port_httpAddress() {
        return IService4BillSOAP11port_http_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String IService4BillSOAP11port_httpWSDDServiceName = "IService4BillSOAP11port_http";

    public java.lang.String getIService4BillSOAP11port_httpWSDDServiceName() {
        return IService4BillSOAP11port_httpWSDDServiceName;
    }

    public void setIService4BillSOAP11port_httpWSDDServiceName(java.lang.String name) {
        IService4BillSOAP11port_httpWSDDServiceName = name;
    }

    public com.webService.service.IService4BillPortType getIService4BillSOAP11port_http() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(IService4BillSOAP11port_http_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getIService4BillSOAP11port_http(endpoint);
    }

    public com.webService.service.IService4BillPortType getIService4BillSOAP11port_http(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.webService.service.IService4BillSOAP11BindingStub _stub = new com.webService.service.IService4BillSOAP11BindingStub(portAddress, this);
            _stub.setPortName(getIService4BillSOAP11port_httpWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setIService4BillSOAP11port_httpEndpointAddress(java.lang.String address) {
        IService4BillSOAP11port_http_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.webService.service.IService4BillPortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.webService.service.IService4BillSOAP11BindingStub _stub = new com.webService.service.IService4BillSOAP11BindingStub(new java.net.URL(IService4BillSOAP11port_http_address), this);
                _stub.setPortName(getIService4BillSOAP11port_httpWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("IService4BillSOAP11port_http".equals(inputPortName)) {
            return getIService4BillSOAP11port_http();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://webservice.ws.nc/IService4Bill", "IService4Bill");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://webservice.ws.nc/IService4Bill", "IService4BillSOAP11port_http"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("IService4BillSOAP11port_http".equals(portName)) {
            setIService4BillSOAP11port_httpEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
