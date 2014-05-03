/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.data.BaseFetcher;
    import com.whatanadventure.framework.data.IFetcher;

    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class PackagedDataFetcher extends BaseFetcher implements IFetcher
    {
        public function PackagedDataFetcher()
        {
            super();

            //TODO: figure out the real path here
//            getPackagedAssetManifestAt("app:/../PackagedAssetsManifest.json");
//            getPackagedAssetManifestAt(File.applicationStorageDirectory.resolvePath("PackagedAssetsManifest.json").url);
            getPackagedAssetManifestAt("data/PackagedAssetsManifest.json");
        }
        protected var _manifestData:Object;
        protected var _fetchingManifest:Boolean;
        private var _waitingOnManifest:Boolean;

        public function get isFetching():Boolean
        {
            return false;
        }

        public function fetchGameData():void
        {
            if (_manifestData)
            {
                if (!_fetchingManifest)
                    receivedManifest();
            }
            else
            {
                if (!_fetchingManifest)
                    getPackagedAssetManifestAt("PackagedAssetsManifest.json");
                else
                    _waitingOnManifest = true;
            }

        }

        protected function getPackagedAssetManifestAt(url:String):void
        {
            _fetchingManifest = true;

            var urlRequest:URLRequest  = new URLRequest(url);

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, manifestResponse);

            try{
                urlLoader.load(urlRequest);
            } catch (error:Error) {
                trace("Cannot load : " + error.message);
            }
        }

        private function receivedManifest():void
        {
            var filePaths:Array;
            for (var fetchType:String in _manifestData)
            {
                filePaths = _manifestData[fetchType];
            }
        }

        private function manifestResponse(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            _manifestData = JSON.parse(loader.data);
            _fetchingManifest = false;

            if (_waitingOnManifest)
                receivedManifest();
        }
    }
}
