/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.managers
{
    import com.whatanadventure.framework.data.IFetcher;

    import flash.events.ProgressEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class BaseResourceManager extends EventDispatcher
    {
        protected var _dataFetchers:Vector.<IFetcher>;
        protected var _urlLoaders:Vector.<URLLoader>;
        private var _numCompletedFetchers:int;
        
        public function BaseResourceManager()
        {
            super();

            _dataFetchers = new Vector.<IFetcher>();
        }

        public function fetchData():void
        {
            _numCompletedFetchers = 0;
            clearLoaders();
            _urlLoaders = new Vector.<URLLoader>();

            for each (var dataFetcher:IFetcher in _dataFetchers)
            {
                dataFetcher.fetchGameData();
            }
        }

        protected function addDataFetcher(dataFetcher:IFetcher):void
        {
            _dataFetchers.push(dataFetcher);
            (dataFetcher as EventDispatcher).addEventListener(Event.COMPLETE, onFetcherComplete);
        }

        private function onFetcherComplete(event:Event):void
        {
            event.target.removeEventListener(Event.COMPLETE, onFetcherComplete);
            _numCompletedFetchers++;

            if (_numCompletedFetchers >= _dataFetchers.length)
            {
                trace("ALL DATA FETCHERS DONE!");
                dispatchEventWith(Event.COMPLETE);
            }
        }

        public function getProjectFileAt(url:String, completeCallback:Function, failCallback:Function = null):URLLoader
        {
            var urlRequest:URLRequest  = new URLRequest(url);

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
            urlLoader.addEventListener(Event.COMPLETE, completeCallback);

            try{
                urlLoader.load(urlRequest);
            } catch (error:Error) {
                trace("Cannot load : " + error.message);
                if (failCallback)
                    failCallback(error.message);

            }

            addURLLoader(urlLoader);

            return urlLoader;
        }

        private function addURLLoader(urlLoader:URLLoader):void
        {
            if (_urlLoaders.indexOf(urlLoader) == -1)
                _urlLoaders.push(urlLoader);
        }

        protected function clearLoaders():void
        {
            for each (var urlLoader:URLLoader in _urlLoaders)
            {
                urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            }
            _urlLoaders = null;
        }

        private function removeLoader(urlLoader:URLLoader):URLLoader
        {
            urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            urlLoader = _urlLoaders.splice(_urlLoaders.indexOf(urlLoader), 1) as URLLoader;
            return urlLoader;
        }

        private function onProgress(event:ProgressEvent):void
        {
            var bytesLoaded:int = 0;
            var bytesTotal:int = 0;
            for each (var urlLoader:URLLoader in _urlLoaders)
            {
                bytesLoaded += urlLoader.bytesLoaded;
                bytesTotal += urlLoader.bytesTotal
            }

//            trace(bytesLoaded + "/" + bytesTotal + " = " + ((bytesLoaded/bytesTotal) * 100) + "%");

            dispatchEventWith(ProgressEvent.PROGRESS, false, {"bytesLoaded":bytesLoaded, "bytesTotal":bytesTotal});
        }

//        protected function onComplete(event:flash.events.Event):void
//        {
//            trace("onComplete");
//            var bytesLoaded:int = 0;
//            var bytesTotal:int = 0;
//            for each (var urlLoader:URLLoader in _urlLoaders)
//            {
//                bytesLoaded += urlLoader.bytesLoaded;
//                bytesTotal += urlLoader.bytesTotal
//            }
//
//            if (bytesLoaded >= bytesTotal)
//            {
//                trace("LOADING COMPLETE!");
//                dispatchEventWith(ProgressEvent.PROGRESS, false, {"bytesLoaded": bytesLoaded, "bytesTotal": bytesTotal});
//            }
//        }
    }
}
