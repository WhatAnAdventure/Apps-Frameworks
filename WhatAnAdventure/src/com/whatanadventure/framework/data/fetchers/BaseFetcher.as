/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.managers.BaseResourceManager;
    import com.whatanadventure.framework.managers.IModelManager;

    import flash.events.Event;
    import flash.net.URLLoader;

    import starling.events.EventDispatcher;

    public class BaseFetcher extends EventDispatcher
    {
        protected var _numFilesRequesting:int;
        protected var _numFilesReceived:int;
        protected var _isFetching:Boolean;
        protected var _manifestData:Object;
        protected var _resourceManager:BaseResourceManager;

        public function BaseFetcher(resourceManager:BaseResourceManager)
        {
            super();
            _resourceManager = resourceManager;
        }

        public function get isFetching():Boolean
        {
            return _isFetching;
        }

        public function fetchGameData():void
        {
            if (_isFetching)
                return;
            _isFetching = true;

            (this as IFetcher).fetchManifest();
        }

        protected function receivedManifest(event:Event):void
        {
            _numFilesRequesting = 0;
            _numFilesReceived = 0;

            var loader:URLLoader = URLLoader(event.target);
            _manifestData = JSON.parse(loader.data);
        }

        protected function receivedFileData(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            var fileData:Object = JSON.parse(loader.data);
            dispatchEventWith(FetcherEvent.RECEIVED_FILE, false, fileData);

            _numFilesReceived++;

            if (_numFilesReceived >= _numFilesRequesting)
            {
                onComplete();
            }
        }

        public function onComplete():void
        {
            dispatchEventWith(Event.COMPLETE, false, {"fetcher":this});
        }
    }
}
