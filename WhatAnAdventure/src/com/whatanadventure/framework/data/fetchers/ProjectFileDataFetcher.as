/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.managers.BaseGameManager;

    public class ProjectFileDataFetcher extends BaseFetcher implements IFetcher
    {
        protected var _manifestURL:String;

        public function ProjectFileDataFetcher(gameManager:BaseGameManager, manifestURL:String)
        {
            super(gameManager);

            _manifestURL = manifestURL;
        }

        public function fetchManifest():void
        {
            _gameManager.resourceManager.getProjectFileAt(_manifestURL, receivedManifest);
        }
    }
}
