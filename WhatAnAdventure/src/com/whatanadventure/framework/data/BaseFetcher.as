/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data
{
    import flash.events.Event;

    import starling.events.EventDispatcher;

    public class BaseFetcher extends EventDispatcher
    {
        protected var _numFilesRequesting:int;
        protected var _numFilesReceived:int;
        protected var _isFetching:Boolean;

        public function BaseFetcher()
        {
            super();
        }

        public function get isFetching():Boolean
        {
            return _isFetching;
        }

        public function fetchGameData():void
        {
            if (_isFetching)
                return;
            _isFetching = true;
        }

        protected function receivedFileData(event:Event):void
        {
            _numFilesReceived++;

            if (_numFilesReceived >= _numFilesRequesting)
            {
                onComplete();
            }
        }

        public function onComplete():void
        {
            dispatchEventWith(Event.COMPLETE, false, {"fetcher":this});
        }
    }
}
