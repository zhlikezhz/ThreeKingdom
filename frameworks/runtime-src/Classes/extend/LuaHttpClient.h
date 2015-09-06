#pragma 
#include "cocos2d.h"
USING_NS_CC;

#include "cocos-ext.h"
USING_NS_CC_EXT;

#include "network/HttpClient.h"
#include "network/HttpResponse.h"

class LuaHttpInfo {
public:
	LuaHttpInfo();

	const char* getURL() { return mRequestURL; }

	const char* getData() { return mRequestData; }

	const char* getName() { return mRequestName; }

	int getCallbackHandler() { return mRequestCallbackHandler; }

private:
	int mRequestCallbackHandler;
	const char* mRequestURL;
	const char* mRequestData;
	const char* mRequestName;
};

class LuaHttpClient : public Ref{
public:
	static LuaHttpClient* getInstance();

	void asynGet(LuaHttpInfo* info);

	void asynPost(LuaHttpInfo* info);

	void httpCallback(network::HttpClient* sender, network::HttpResponse* response);

private:
	LuaHttpClient() {}
};

