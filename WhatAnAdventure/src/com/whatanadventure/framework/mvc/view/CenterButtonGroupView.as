/**
 * Created by Chelsea on 4/27/2014.
 */
package com.whatanadventure.framework.mvc.view
{
    import com.whatanadventure.adventuregame.managers.GameManager;
    import com.whatanadventure.framework.managers.BaseModelManager;
    import com.whatanadventure.framework.mvc.IMVCView;
    import com.whatanadventure.framework.mvc.MVCView;
    import com.whatanadventure.framework.mvc.layout.CenterButtonGroupLayout;
    import com.whatanadventure.framework.mvc.layout.MVCViewLayout;
    import com.whatanadventure.framework.mvc.models.MVCViewLayouts;

    import feathers.controls.Button;
    import feathers.controls.ButtonGroup;
    import feathers.controls.Header;
    import feathers.controls.Screen;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Quad;
    import starling.events.Event;
    import starling.utils.Color;

    public class CenterButtonGroupView extends Screen implements IMVCView
    {
        private var _gameManager:GameManager;

        private var _bg:DisplayObject;
        private var _header:Header;
        private var _buttonGroup:ButtonGroup;

        private var _mvcViewLayouts:MVCViewLayouts;
        private var _mvcViewLayout:MVCViewLayout;

        public function CenterButtonGroupView()
        {
            super();

            layout = new AnchorLayout();
        }

        public function set gameManager(value:GameManager):void
        {
            _gameManager = value;

//            init();
        }

        override public function set screenID(value:String):void
        {
            super.screenID = value;

            if (!_mvcViewLayouts)
                _mvcViewLayouts = _gameManager.modelManager.getModel(BaseModelManager.MVC_VIEWS) as BaseModelManager.MVC_VIEWS_CLASS;
            if (!_mvcViewLayout)
                _mvcViewLayout = _mvcViewLayouts.getViewLayoutById(_screenID);

            init();
        }

        private function init():void
        {
            addBackground();
            addHeader();
            addButtonGroup();

            updateLayout();
        }

        private function addBackground():void
        {
            _bg = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, Color.BLACK);
            addChildAt(_bg, 0);
        }

        private function addHeader():void
        {
            _header = new Header();
            _header.title = (_mvcViewLayout.layoutData as CenterButtonGroupLayout).title;
            _header.layoutData = new AnchorLayoutData();
            (_header.layoutData as AnchorLayoutData).percentWidth = 100;
            addChild(_header);
        }

        private function addButtonGroup():void
        {
            _buttonGroup = new ButtonGroup();
            var buttonGroupDP:ListCollection = new ListCollection();
            for each (var buttonData:Object in (_mvcViewLayout.layoutData as CenterButtonGroupLayout).dataProvider.data)
            {
                buttonGroupDP.data.push({"label": buttonData.label, "triggered": onButtonClicked});
            }
            _buttonGroup.dataProvider = buttonGroupDP;
            var layoutData:AnchorLayoutData = new AnchorLayoutData();
            layoutData.horizontalCenter = 0;
            layoutData.verticalCenter = 0;
            _buttonGroup.layoutData = layoutData;
            addChild(_buttonGroup);
        }

        private function onButtonClicked(event:Event):void
        {
            var functionName:String;
            for each (var buttonData:Object in (_mvcViewLayout.layoutData as CenterButtonGroupLayout).dataProvider.data)
            {
                if (buttonData.label == (event.target as Button).label)
                {
                    functionName = buttonData.triggered;
                    break;
                }
            }

            this[functionName](event);
        }

        public function reinitialize():void
        {
            invalidate(MVCView.INVALIDATION_FLAG_ROTATE);
        }

        override protected function draw():void
        {
            super.draw();

            if (isInvalid(MVCView.INVALIDATION_FLAG_ROTATE))
            {
                updateLayout();
            }
        }

        public function updateLayout():void
        {
            if (_bg && getChildIndex(_bg) != -1)
                _bg.removeFromParent(true);
            addBackground();
        }
    }
}
