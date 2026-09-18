package ir.tapsell.mediation.sample

import android.app.Activity
import android.os.Build
import android.view.View
import android.view.ViewGroup
import android.view.ViewTreeObserver
import android.view.WindowInsets
import androidx.annotation.RequiresApi
import ir.tapsell.mediation.ad.views.banner.BannerContainer

@RequiresApi(Build.VERSION_CODES.R)
object InsetHelper {

    /**
     * Watches the activity's content view for BannerContainers added by the
     * Tapsell SDK at runtime and applies window insets to each of them.
     *
     * A keyed tag on the view itself marks it as handled — no view references
     * are kept, and a re-added (or new) banner is handled again.
     */
    fun applyInsetsToBannerContainers(activity: Activity) {
        val insetHandledTag = "tapsell_mediation_sample.insets_handled".hashCode()
        val content = activity.window.decorView.findViewById<ViewGroup>(android.R.id.content)
        content.viewTreeObserver.addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {
            override fun onGlobalLayout() {
                for (i in 0 until content.childCount) {
                    val child = content.getChildAt(i)
                    if (child is BannerContainer && child.getTag(insetHandledTag) == null) {
                        child.setTag(insetHandledTag, true)
                        applyInsets(child)
                    }
                }
            }
        })
    }

    /**
     * Applies the given insets to the view, adjusting its margins to prevent overlap with system UI elements
     * like status bars, navigation bars, or cutouts.
     *
     * This function is typically used to handle window insets and ensure that the ad content
     * is fully visible and not obscured by the system's decorations.
     */
    fun applyInsets(view: View) {
        view.setOnApplyWindowInsetsListener { v, windowInsets ->
            val insets = windowInsets.getInsets(
                WindowInsets.Type.systemBars() or WindowInsets.Type.displayCutout()
            )

            (v.layoutParams as? ViewGroup.MarginLayoutParams)?.setMargins(
                /* left = */ insets.left,
                /* top = */ insets.top,
                /* right = */ insets.right,
                /* bottom = */ insets.bottom,
            )

            WindowInsets.CONSUMED
        }
    }
}
