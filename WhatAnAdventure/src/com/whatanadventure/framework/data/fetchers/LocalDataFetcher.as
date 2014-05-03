/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.data.BaseFetcher;
    import com.whatanadventure.framework.data.IFetcher;

    public class LocalDataFetcher extends BaseFetcher implements IFetcher
    {
        public function LocalDataFetcher()
        {
            super();
        }

        public function get isFetching():Boolean
        {
            return false;
        }

        public function fetchGameData():void
        {
        }
    }
}
