/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.data.BaseFetcher;
    import com.whatanadventure.framework.data.IFetcher;

    import flash.events.Event;

    import flash.filesystem.File;
    import flash.net.FileFilter;
    import flash.net.FileReference;

    public class LocalDataFetcher extends BaseFetcher implements IFetcher
    {
        protected var _manifest:File;

        public function LocalDataFetcher()
        {
            super();
        }

        override public function fetchGameData():void
        {
            super.fetchGameData();

            _manifest = new File();
            _manifest.addEventListener(Event.SELECT, onManifestChosen);
            _manifest.browseForOpen("Select manifest file ...", [new FileFilter("json", "*.json")]);
        }

        private function onManifestChosen(event:Event):void
        {
            var loadFile:File = event.target as File;
            trace('here');
        }
    }
}
