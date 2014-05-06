/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.managers.BaseGameManager;
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
        protected var _gameManager:BaseGameManager;

        public function BaseFetcher(gameManager:BaseGameManager)
        {
            super();
            _gameManager = gameManager;
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

            var paths:Array;
            for (var fetchType:String in _manifestData)
            {
                paths = _manifestData[fetchType];
                _numFilesRequesting += paths.length;
                var path:String;
                for each (path in paths)
                {
                    _gameManager.resourceManager.getProjectFileAt(path, receivedFileData);
                }
            }
        }

        protected function receivedFileData(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            var fileData:Object = JSON.parse(loader.data);
            (_gameManager.modelManager as IModelManager).makeModelFromData(fileData);

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
