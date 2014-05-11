/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.mvc
{
    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class MVCModel extends EventDispatcher
    {
        protected var _modelName:String;

        public function MVCModel(modelName:String)
        {
            super();

            _modelName = modelName;
        }

        public function get name():String
        {
            return _modelName;
        }

        public function setProperty(name:String, value:*, suppressChange:Boolean = false):void
        {
            if (this.hasOwnProperty(name) && this[name] != value)
            {
                this[name] = value;
                if (!suppressChange)
                    dispatchEventWith(Event.CHANGE, false, {"model": this, "properties": {name:name}});
            }
        }

        public function getProperty(name:String):*
        {
            var result:*;

            if (this.hasOwnProperty(name))
                result = this[name];

            return result;
        }

        public function setProperties(properties:Object):void
        {
            for (var name:String in properties)
            {
                setProperty(name, properties[name], true);
            }
            dispatchEventWith(Event.CHANGE, false, {"model": this, "properties": properties});
        }
    }
}
