#include "CCLuaEngine.h"
#include "extend/LuaHttpClient.h"

LuaHttpInfo::LuaHttpInfo()
: mRequestURL(nullptr)
, mRequestData(nullptr)
, mRequestName(nullptr)
, mRequestCallbackHandler(0)
{

}

LuaHttpClient* LuaHttpClient::getInstance()
{
	static LuaHttpClient client;
	return &client;
}

void LuaHttpClient::asynGet(LuaHttpInfo* info)
{
	network::HttpRequest* request = new network::HttpRequest();
	request->setUrl(info->getURL());
	request->setRequestType(network::HttpRequest::Type::GET);
	request->setResponseCallback(this, httpresponse_selector(LuaHttpClient::httpCallback));
	request->setUserData(static_cast<void*>(info));
	network::HttpClient::getInstance()->send(request);
	request->release();
}

void LuaHttpClient::asynPost(LuaHttpInfo* info)
{
	network::HttpRequest* request = new network::HttpRequest();
	request->setUrl(info->getURL());
	request->setRequestType(network::HttpRequest::Type::POST);
	request->setResponseCallback(this, httpresponse_selector(LuaHttpClient::httpCallback));
	request->setRequestData(info->getData(), strlen(info->getData()));
	request->setUserData(static_cast<void*>(info));
	network::HttpClient::getInstance()->send(request);
	request->release();
}

void LuaHttpClient::httpCallback(network::HttpClient *sender, network::HttpResponse *response)
{
	if(!response) {
		return;
	}

	/*
	int statusCode = response->getResponseCode();
	char statusString[64] = {};
	sprintf(statusString, "HTTP Status Code: %d, tag = %s", statusCode, response->getHttpRequest()->getTag());
	CCLog("response code: %d", statusCode);
	*/
	LuaHttpInfo* info = static_cast<LuaHttpInfo*>(response->getHttpRequest()->getUserData());
	LuaStack* stack = LuaEngine::getInstance()->getLuaStack();
	std::vector<char> *buffer = response->getResponseData();
	std::string data(buffer->begin(), buffer->end());
	stack->pushString(info->getName());
	stack->pushString(data.c_str());
	stack->executeFunctionByHandler(info->getCallbackHandler(), 1);
	stack->clean();
	delete info;
}
