/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.framework.mvc.models
{
    import com.whatanadventure.framework.data.IJsonObject;
    import com.whatanadventure.framework.managers.BaseGameManager;
    import com.whatanadventure.framework.mvc.IMVCModel;
    import com.whatanadventure.framework.mvc.MVCModel;
    import com.whatanadventure.framework.mvc.layout.CenterButtonGroupLayout;
    import com.whatanadventure.framework.mvc.layout.MVCViewLayout;
    import com.whatanadventure.framework.mvc.layout.MVCViewLayoutData;

    public class MVCViewLayouts extends MVCModel implements IMVCModel, IJsonObject
    {
        public static const CenterButtonGroup_LAYOUT:Class = CenterButtonGroupLayout;

        protected var _mvcViewLayouts:Vector.<MVCViewLayout>;

        public function MVCViewLayouts(gameManager:BaseGameManager, modelName:String)
        {
            super(gameManager, modelName);
        }

        public function getViewLayoutById(viewId:String):MVCViewLayout
        {
            var result:MVCViewLayout;

            for each (var iViewLayout:MVCViewLayout in _mvcViewLayouts)
            {
                if (iViewLayout.viewId == viewId)
                {
                    result = iViewLayout;
                    break;
                }
            }

            return result;
        }

        public function toJSON():Object
        {
            return null;
        }

        public function fromJSON(jsonData:Object):void
        {
            _mvcViewLayouts = new Vector.<MVCViewLayout>();

            var mvcViewLayout:MVCViewLayout;
            var mvcViewLayoutData:MVCViewLayoutData;
            var layoutDataClass:Class;

            for each (var layoutJson:Object in jsonData.views)
            {
                mvcViewLayout = new MVCViewLayout();
                mvcViewLayout.layoutClass = layoutJson.layoutClass;
                mvcViewLayout.viewId = layoutJson.viewId;

                layoutDataClass = MVCViewLayouts[mvcViewLayout.layoutClass + "_LAYOUT"];
                mvcViewLayoutData = new layoutDataClass() as MVCViewLayoutData;
                (mvcViewLayoutData as IJsonObject).fromJSON(layoutJson.layoutData);
                mvcViewLayout.layoutData = mvcViewLayoutData;

                _mvcViewLayouts.push(mvcViewLayout);
            }
        }
    }
}
