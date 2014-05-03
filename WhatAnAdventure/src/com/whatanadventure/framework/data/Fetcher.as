/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data
{
    import com.whatanadventure.framework.data.fetchers.PackagedDataFetcher;

    import starling.events.EventDispatcher;

    public class Fetcher extends EventDispatcher
    {
        public function Fetcher()
        {
            super();

            _dataFetchers = new Vector.<IFetcher>();

            addDataFetcher(new PackagedDataFetcher());

            fetchData();
        }
        private var _dataFetchers:Vector.<IFetcher>;

        private function fetchData():void
        {
            for each (var dataFetcher:IFetcher in _dataFetchers)
            {
                dataFetcher.fetchGameData();
            }
        }

        private function addDataFetcher(dataFetcher:IFetcher):void
        {
            _dataFetchers.push(dataFetcher);
        }
    }
}
