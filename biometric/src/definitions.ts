export enum BiometryType {
  NONE,
  TOUCH_ID,
  FACE_ID,
  FINGERPRINT,
  FACE_AUTHENTICATION,
  IRIS_AUTHENTICATION,
}

export interface AvailableResult {
  isAvailable: boolean;
  biometryType: BiometryType;
}

export interface BiometricOptions {
  reason?: string;
  title?: string;
  subtitle?: string;
  description?: string;
  negativeButtonText?: string;
}

export interface BiometricPlugin {
  isAvailable(): Promise<AvailableResult>;

  verifyIdentity(options?: BiometricOptions): Promise<any>;
}
