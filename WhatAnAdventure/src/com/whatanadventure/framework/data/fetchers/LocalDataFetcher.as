/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.config.FrameworkConfig;
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.managers.BaseResourceManager;

    import flash.events.Event;
    import flash.filesystem.File;
    import flash.net.FileFilter;
    import flash.net.SharedObject;

    public class LocalDataFetcher extends BaseFetcher implements IFetcher
    {
        protected var _savedManifestURL:String;
        protected var _sharedObject:SharedObject;

        public function LocalDataFetcher(resourceManager:BaseResourceManager)
        {
            super(resourceManager);

            _sharedObject = SharedObject.getLocal(FrameworkConfig.SHARED_OBJECT_NAME);
            if (_sharedObject.data.savedManifestURL)
                _savedManifestURL = _sharedObject.data.savedManifestURL;
        }

        public function fetchManifest():void
        {
            if (!_savedManifestURL || _savedManifestURL == "")
            {
                var file:File = new File();
                file.addEventListener(Event.SELECT, onManifestChosen);
                file.browseForOpen("Select manifest file ...", [new FileFilter("json", "*.json")]);
            }
            else
            {
                _resourceManager.getProjectFileAt(_savedManifestURL, receivedManifest);
            }
        }

        private function onManifestChosen(event:Event):void
        {
            var loadFile:File = event.target as File;
            savedManifestURL = loadFile.url;
            _resourceManager.getProjectFileAt(loadFile.url, receivedManifest);
        }

        public function set savedManifestURL(value:String):void
        {
            _savedManifestURL = value;

            _sharedObject.data.savedManifestURL = _savedManifestURL;
            _sharedObject.flush();
        }
    }
}
