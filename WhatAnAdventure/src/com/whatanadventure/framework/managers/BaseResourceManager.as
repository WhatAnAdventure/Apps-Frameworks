/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.managers
{
    import com.whatanadventure.framework.data.fetchers.BaseFetcher;
    import com.whatanadventure.framework.data.fetchers.FetcherEvent;

    import flash.events.ProgressEvent;
    import flash.net.URLLoader;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class BaseResourceManager extends EventDispatcher
    {
        protected var _dataFetchers:Vector.<BaseFetcher>;
        protected var _urlLoaders:Vector.<URLLoader>;
        private var _numCompletedFetchers:int;
        protected var _modelManager:BaseModelManager;

        public function BaseResourceManager(modelManager:BaseModelManager)
        {
            super();

            _modelManager = modelManager;
            _dataFetchers = new Vector.<BaseFetcher>();
        }

        public function fetchData():void
        {
            _numCompletedFetchers = 0;
            clearLoaders();
            _urlLoaders = new Vector.<URLLoader>();

            for each (var dataFetcher:BaseFetcher in _dataFetchers)
            {
                dataFetcher.fetchGameData();
            }
        }

        protected function addDataFetcher(dataFetcher:BaseFetcher):void
        {
            _dataFetchers.push(dataFetcher);
            (dataFetcher as EventDispatcher).addEventListener(Event.COMPLETE, onFetcherComplete);
            (dataFetcher as EventDispatcher).addEventListener(FetcherEvent.RECEIVED_FILE, onReceiveFile);
        }

        private function onReceiveFile(event:Event):void
        {
            (_modelManager as IModelManager).makeModelFromData(event.data);
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

        public function addURLLoader(urlLoader:URLLoader):void
        {
            if (_urlLoaders.indexOf(urlLoader) == -1)
            {
                _urlLoaders.push(urlLoader);
                urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
            }
        }

        protected function clearLoaders():void
        {
            for each (var urlLoader:URLLoader in _urlLoaders)
            {
                urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            }
            _urlLoaders = null;
        }

        public function removeLoader(urlLoader:URLLoader):URLLoader
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
