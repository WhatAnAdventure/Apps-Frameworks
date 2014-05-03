/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.data.BaseFetcher;
    import com.whatanadventure.framework.data.IFetcher;
    import com.whatanadventure.framework.data.ManifestObject;
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.managers.BaseResourceManager;
    import com.whatanadventure.framework.managers.IModelManager;

    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class ProjectFileDataFetcher extends BaseFetcher implements IFetcher
    {
        private var _gameManager:BaseGameManager;

        protected var _manifestURL:String;
        protected var _manifestData:Object;
        protected var _isFetching:Boolean;

        public function ProjectFileDataFetcher(gameManager:BaseGameManager, manifestURL:String)
        {
            super();

            _gameManager = gameManager;
            _manifestURL = manifestURL;
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

            _gameManager.resourceManager.getProjectFileAt(_manifestURL, receivedManifest);
        }

        protected function receivedManifest(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            _manifestData = JSON.parse(loader.data);

            var paths:Array;
            for (var fetchType:String in _manifestData)
            {
                paths = _manifestData[fetchType];
                var path:String;
                for each (path in paths)
                {
                    _gameManager.resourceManager.getProjectFileAt(path, receivedFileData);
                }
            }
        }

        private function receivedFileData(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            var fileData:Object = JSON.parse(loader.data);
            (_gameManager.modelManager as IModelManager).makeModelFromData(fileData);
        }
    }
}
