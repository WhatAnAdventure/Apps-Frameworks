/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.managers.BaseResourceManager;

    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class ProjectFileDataFetcher extends BaseFetcher implements IFetcher
    {
        protected var _manifestURL:String;

        public function ProjectFileDataFetcher(resourceManager:BaseResourceManager, manifestURL:String)
        {
            super(resourceManager);

            _manifestURL = manifestURL;
        }

        public function fetchManifest():void
        {
            getProjectFileAt(_manifestURL, receivedManifest);
        }

        override protected function receivedManifest(event:Event):void
        {
            super.receivedManifest(event);

            var paths:Array;
            for (var fetchType:String in _manifestData)
            {
                paths = _manifestData[fetchType];
                _numFilesRequesting += paths.length;
                var path:String;
                for each (path in paths)
                {
                    getProjectFileAt(path, super.receivedFileData);
                }
            }
        }

        public function getProjectFileAt(url:String, completeCallback:Function, failCallback:Function = null):URLLoader
        {
            var urlRequest:URLRequest = new URLRequest(url);

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, completeCallback);
            _resourceManager.addURLLoader(urlLoader);

            try{
                urlLoader.load(urlRequest);
            } catch (error:Error) {
                trace("Cannot load : " + error.message);
                urlLoader.removeEventListener(Event.COMPLETE, completeCallback);
                _resourceManager.removeLoader(urlLoader);
                if (failCallback)
                    failCallback(error.message);

            }


            return urlLoader;
        }
    }
}
