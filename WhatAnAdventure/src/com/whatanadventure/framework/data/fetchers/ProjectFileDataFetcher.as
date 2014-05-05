/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.data.BaseFetcher;
    import com.whatanadventure.framework.data.IFetcher;
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.managers.IModelManager;

    import flash.events.Event;

    import flash.net.URLLoader;

    public class ProjectFileDataFetcher extends BaseFetcher implements IFetcher
    {
        private var _gameManager:BaseGameManager;

        protected var _manifestURL:String;
        protected var _manifestData:Object;

        public function ProjectFileDataFetcher(gameManager:BaseGameManager, manifestURL:String)
        {
            super();

            _gameManager = gameManager;
            _manifestURL = manifestURL;
        }

        override public function fetchGameData():void
        {
            super.fetchGameData();

            fetchManifest();
        }

        protected function fetchManifest():void
        {
            _gameManager.resourceManager.getProjectFileAt(_manifestURL, receivedManifest);
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

        override protected function receivedFileData(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            var fileData:Object = JSON.parse(loader.data);
            (_gameManager.modelManager as IModelManager).makeModelFromData(fileData);

            super.receivedFileData(event);
        }
    }
}
