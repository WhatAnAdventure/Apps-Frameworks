/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.managers
{
    import com.whatanadventure.framework.data.IFetcher;
    import com.whatanadventure.framework.data.fetchers.ProjectFileDataFetcher;

    import flash.net.URLLoader;

    import flash.net.URLRequest;

    import starling.events.Event;

    import starling.events.EventDispatcher;

    public class BaseResourceManager extends EventDispatcher
    {
        protected var _dataFetchers:Vector.<IFetcher>;
        
        public function BaseResourceManager()
        {
            super();

            _dataFetchers = new Vector.<IFetcher>();
        }

        public function fetchData():void
        {
            for each (var dataFetcher:IFetcher in _dataFetchers)
            {
                dataFetcher.fetchGameData();
            }
        }

        protected function addDataFetcher(dataFetcher:IFetcher):void
        {
            _dataFetchers.push(dataFetcher);
        }

        public function getProjectFileAt(url:String, successCallback:Function, failCallback:Function = null):void
        {
            var urlRequest:URLRequest  = new URLRequest(url);

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, successCallback);

            try{
                urlLoader.load(urlRequest);
            } catch (error:Error) {
                trace("Cannot load : " + error.message);
                if (failCallback)
                    failCallback(error.message);
            }
        }
    }
}
