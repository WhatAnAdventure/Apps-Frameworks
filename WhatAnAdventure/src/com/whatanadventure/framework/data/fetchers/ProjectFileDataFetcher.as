/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.managers.BaseResourceManager;

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
            _resourceManager.getProjectFileAt(_manifestURL, receivedManifest);
        }
    }
}
