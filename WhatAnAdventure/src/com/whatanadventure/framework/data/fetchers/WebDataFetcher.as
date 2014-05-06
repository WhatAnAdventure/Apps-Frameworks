/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data.fetchers
{
    import com.whatanadventure.framework.data.fetchers.BaseFetcher;
    import com.whatanadventure.framework.data.fetchers.IFetcher;

    public class WebDataFetcher extends BaseFetcher implements IFetcher
    {
        public function WebDataFetcher()
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
