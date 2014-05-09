/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.managers.BaseGameManager;

    public class WebDataFetcher extends BaseFetcher implements IFetcher
    {
        public function WebDataFetcher(gameManager:BaseGameManager)
        {
            super(gameManager);
        }

        public function fetchManifest():void
        {
        }
    }
}
